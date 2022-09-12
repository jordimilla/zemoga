import Foundation
import Combine
import Domain
import CoreData

public struct CoreDataRepositoryImpl: CoreDataRepository {

    private let coreDataStore: CoreDataStoring

    public init(coreDataStore: CoreDataStoring) {
        self.coreDataStore = coreDataStore
    }
    
    public func deleteAllPost() {
        var cancellables = Set<AnyCancellable>()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: PostDB.entityName)
        coreDataStore
            .publicher(delete: request)
            .sink { completion in
            } receiveValue: { success in
            }
            .store(in: &cancellables)
    }
    
    public func deleteAllComments() {
        var cancellables = Set<AnyCancellable>()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: CommentDB.entityName)
        coreDataStore
            .publicher(delete: request)
            .sink { completion in
            } receiveValue: { success in
            }
            .store(in: &cancellables)
    }
    
    public func createPostDBEntities(posts: [Post]) {
        var cancellables = Set<AnyCancellable>()
        let action: Action = {
            for post in posts {
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
    
    public func createCommentDBEntities(comments: [Comment]) {
       // var cancellables = Set<AnyCancellable>()
    }
    
    public func fetchCommentsFromStored() {
        //var cancellables = Set<AnyCancellable>()
    }
    
    public func fetchPostFromStored() -> AnyPublisher<[PostDB], Error> {
        let request = NSFetchRequest<PostDB>(entityName: PostDB.entityName)
        return coreDataStore
            .publicher(fetch: request)
            .tryMap { items in
                return items
            }
            .eraseToAnyPublisher()
    }
    
    public func deleteAllPostHasNotFavorite() -> AnyPublisher<NSBatchDeleteResult, Error> {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: PostDB.entityName)
        request.predicate = NSPredicate(format: "hasFavorite == %@", NSNumber(value: false))
        return coreDataStore
            .publicher(delete: request)
            .tryMap { success in
                return success
            }
            .eraseToAnyPublisher()
    }
    
    public func updateFavoritePost(post: PostDB) -> AnyPublisher<Bool, Error> {
        let action : Action = {
            post.setValue(!post.hasFavorite, forKey: "hasFavorite")
        }
        
        return coreDataStore
            .publicher(save: action)
            .tryMap { items in
                return items
            }
            .eraseToAnyPublisher()
    }
    
    public func getPostDB(id: Int) -> AnyPublisher<PostDB, Error> {
        let request = NSFetchRequest<PostDB>(entityName: PostDB.entityName)
        request.predicate = NSPredicate(format: "id == %@", NSNumber(value: id))
        return coreDataStore
            .publicher(fetch: request)
            .tryMap { items in
                guard let post: PostDB = items.first else { return PostDB()}
                return post
            }
            .eraseToAnyPublisher()
    }
}
