import Foundation
import Combine
import CoreData

public protocol CoreDataRepository {
    func getPostDB(id: Int) -> AnyPublisher<PostDB, Error> 
    
    func deletePost(post: Post) -> AnyPublisher<NSBatchDeleteResult, Error>
    func deleteAllPost()
    func deleteAllComments()
    func deleteAllPostHasNotFavorite() -> AnyPublisher<NSBatchDeleteResult, Error>
    
    func createPostDBEntities(posts:[Post])
    func createCommentDBEntities(comments: [Comment])
    
    func fetchPostFromStored() -> AnyPublisher<[PostDB], Error> 
    func fetchCommentsFromStored(post: Post) -> AnyPublisher<[CommentDB], Error> 
    
    func updateFavoritePost(post: PostDB) -> AnyPublisher<Bool, Error>
}
