import Foundation
import Combine
import CoreData
@testable import Domain

struct MockCoreDataRepository: CoreDataRepository {
    func getPostDB(id: Int) -> AnyPublisher<PostDB, Error> {
        return Just(PostDB())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func deletePost(post: Post) -> AnyPublisher<NSBatchDeleteResult, Error> {
        return Just(NSBatchDeleteResult())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func fetchPostFromStored() -> AnyPublisher<[PostDB], Error> {
        return Just([PostDB]())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func fetchCommentsFromStored(post: Post) -> AnyPublisher<[CommentDB], Error> {
        return Just([CommentDB]())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func updateFavoritePost(post: PostDB) -> AnyPublisher<Bool, Error> {
        return Just(true)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func deleteAllPostHasNotFavorite() -> AnyPublisher<NSBatchDeleteResult, Error> {
        return Just(NSBatchDeleteResult())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func deleteAllPost() {
        
    }
    
    func deleteAllComments() {
        
    }
        
    func createPostDBEntities(posts: [Post]) {
        
    }
    
    func createCommentDBEntities(comments: [Comment]) {
        
    }
    

}
