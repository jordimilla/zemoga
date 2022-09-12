import Foundation
import Domain
import UIKit
import Combine
import CoreData

final class PostListViewModel {
    
    private let fetchPostListUseCase: FetchPostsListUseCase
    private let getPostDBUseCase: GetPostDBUseCase
    private let updateFavoritePostUseCase: UpdateFavoritePostUseCase
    private let fetchPostFromStoredUseCase: FetchPostFromStoredUseCase
    private let createPostDBEntitiesUseCase: CreatePostDBEntitiesUseCase
    private let deleteAllPostDBUseCase: DeleteAllPostDBUseCase
    private let deleteAllPostHasNotFavoriteUseCase: DeleteAllPostHasNotFavoriteUseCase
    private let deleteAllCommentDBUseCase: DeleteAllCommentDBUseCase
    private let deletePostDBUseCase: DeletePostDBUseCase
    private let nextFeature: SingleParamFeatureProvider<Post>
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var posts: [Post] = []
    @Published private(set) var alert: Bool = false
    
    init(fetchPostListUseCase: FetchPostsListUseCase,
         getPostDBUseCase: GetPostDBUseCase,
         updateFavoritePostUseCase: UpdateFavoritePostUseCase,
         fetchPostFromStoredUseCase: FetchPostFromStoredUseCase,
         createPostDBEntitiesUseCase: CreatePostDBEntitiesUseCase,
         deleteAllPostDBUseCase: DeleteAllPostDBUseCase,
         deleteAllPostHasNotFavoriteUseCase: DeleteAllPostHasNotFavoriteUseCase,
         deleteAllCommentDBUseCase: DeleteAllCommentDBUseCase,
         deletePostDBUseCase: DeletePostDBUseCase,
         nextFeature: @escaping SingleParamFeatureProvider<Post>) {
        self.fetchPostListUseCase = fetchPostListUseCase
        self.getPostDBUseCase = getPostDBUseCase
        self.updateFavoritePostUseCase = updateFavoritePostUseCase
        self.fetchPostFromStoredUseCase = fetchPostFromStoredUseCase
        self.createPostDBEntitiesUseCase = createPostDBEntitiesUseCase
        self.deleteAllPostDBUseCase = deleteAllPostDBUseCase
        self.deleteAllPostHasNotFavoriteUseCase = deleteAllPostHasNotFavoriteUseCase
        self.deleteAllCommentDBUseCase = deleteAllCommentDBUseCase
        self.deletePostDBUseCase = deletePostDBUseCase
        self.nextFeature = nextFeature
    }
    
    func goToDetailPost(navigationController: UINavigationController, post: Post) {
        let viewController = nextFeature(navigationController, post)
        navigationController.pushViewController(viewController, animated: true)
    }
}

// MARK: - API
extension PostListViewModel {
    func fetchPosts() {
        fetchPostListUseCase.execute(value: ())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    self.alert = true
                    break
                }
            }, receiveValue: { [weak self] items in
                self?.posts = items
                self?.deleteAllPost()
                self?.deleteAllComments()
                self?.createEntity(posts: items)
            })
            .store(in: &cancellables)
    }
}

// MARK: - CoreData
extension PostListViewModel {
    func createEntity(posts: [Post]) {
        createPostDBEntitiesUseCase.execute(value: posts)
    }
    
    func fetchPostFromStored() {
        fetchPostFromStoredUseCase.execute(value: ())
            .sink(receiveCompletion: { completion in
            }, receiveValue: { [weak self] items in
                if items.count == 0 {
                    self?.fetchPosts()
                } else {
                    let posts = PostDB.mapPosts(input: items)
                    self?.posts = posts
                }
            })
            .store(in: &cancellables)
    }
    
    func deleteAllPost() {
        deleteAllPostDBUseCase.execute()
    }
    
    func deleteAllComments() {
        deleteAllCommentDBUseCase.execute()
    }
    
    func deleteAllPostHasNotFavorite() {
        deleteAllPostHasNotFavoriteUseCase.execute(value: ())
            .sink(receiveCompletion: { completion in
            }, receiveValue: { [weak self] success in
                self?.fetchPostFromStored()
            })
            .store(in: &cancellables)
    }
    
    func setFavoritePost(id: Int) {
        getPostDBUseCase.execute(value: id)
            .sink(receiveCompletion: { completion in
            }, receiveValue: { [weak self] item in
                self?.updatePost(post: item)
            })
            .store(in: &cancellables)
        
    }
    
    func deletePost(post: Post) {
        deletePostDBUseCase.execute(value: post)
            .sink(receiveCompletion: { completion in
            }, receiveValue: { [weak self] success in
                self?.fetchPostFromStored()
            })
            .store(in: &cancellables)
    }
    
    func updatePost(post: PostDB) {
        updateFavoritePostUseCase.execute(value: post)
            .sink(receiveCompletion: { completion in
            }, receiveValue: { [weak self] success in
                print(success)
                self?.fetchPostFromStored()
            })
            .store(in: &cancellables)
    }
}
