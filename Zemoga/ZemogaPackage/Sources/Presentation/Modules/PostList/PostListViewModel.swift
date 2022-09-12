import Foundation
import Domain
import UIKit
import Combine
import CoreData

final class PostListViewModel {
    
    private let fetchPostListUseCase: FetchPostsListUseCase
    private let nextFeature: SingleParamFeatureProvider<Post>
    private let coreDataStore: CoreDataStoring
    
    private var cancellables = Set<AnyCancellable>()
    @Published private(set) var posts: [Post] = []
    
    init(fetchPostListUseCase: FetchPostsListUseCase,
         nextFeature: @escaping SingleParamFeatureProvider<Post>,
         coreDataStore: CoreDataStoring) {
        self.fetchPostListUseCase = fetchPostListUseCase
        self.nextFeature = nextFeature
        self.coreDataStore =  coreDataStore
    }
    
    func fetchPosts() {
        fetchPostListUseCase.execute(value: ())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }, receiveValue: { [weak self] items in
                self?.posts = items
                self?.deleteAllPost()
                self?.deleteAllComments()
                self?.createEntity()
            })
            .store(in: &cancellables)
    }
    
    func goToDetailPost(navigationController: UINavigationController, post: Post) {
        let viewController = nextFeature(navigationController, post)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func createEntity() {
        let action: Action = {
            for post in self.posts {
                let p: PostDB = self.coreDataStore.createEntity()
                p.id = Int32(post.id)
                p.userId = Int32(post.userId)
                p.title = post.title
                p.body = post.body
                p.hasFavorite = post.hasFavorite ?? false
            }
        }
        
        coreDataStore
            .publicher(save: action)
            .sink { completion in
            } receiveValue: { success in
            }
            .store(in: &cancellables)
    }
    
    func fetchPostFromStored() {
        let request = NSFetchRequest<PostDB>(entityName: PostDB.entityName)
        coreDataStore
            .publicher(fetch: request)
            .sink { completion in
            } receiveValue: { items in
                if items.count == 0 {
                    self.fetchPosts()
                } else {
                    let posts = PostDB.mapPosts(input: items)
                    self.posts = posts
                }
                
            }
            .store(in: &cancellables)
    }
    
    func deleteAllPost() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: PostDB.entityName)
        coreDataStore
            .publicher(delete: request)
            .sink { completion in
            } receiveValue: { success in
            }
            .store(in: &cancellables)
    }
    
    func deleteAllComments() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: CommentDB.entityName)
        coreDataStore
            .publicher(delete: request)
            .sink { completion in
            } receiveValue: { success in
            }
            .store(in: &cancellables)
    }
    
    func deleteAllPostHasNotFavorite() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: PostDB.entityName)
        request.predicate = NSPredicate(format: "hasFavorite == %@", NSNumber(value: false))
        coreDataStore
            .publicher(delete: request)
            .sink { completion in
            } receiveValue: { items in
                self.fetchPostFromStored()
            }
            .store(in: &cancellables)
    }
    
    func setFavoritePost(id: Int, hasFavorite: Bool) {
        
        let request = NSFetchRequest<PostDB>(entityName: PostDB.entityName)
        request.predicate = NSPredicate(format: "id == %@", NSNumber(value: id))
        coreDataStore
            .publicher(fetch: request)
            .sink { completion in
            } receiveValue: { item in
                guard let p: PostDB = item.first else { return }
                let action : Action = {
                    p.setValue(hasFavorite, forKey: "hasFavorite")
                }
                self.coreDataStore
                    .publicher(save: action)
                    .sink { completion in
                    } receiveValue: { success in
                        self.fetchPostFromStored()
                    }
                    .store(in: &self.cancellables)
                
            }
            .store(in: &cancellables)
        
    }
}

