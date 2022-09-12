import Foundation
import CoreData

public struct Comment: Codable {
    public let postId: Int
    public let id: Int
    public let name: String
    public let email: String
    public let body: String
    
    public init(postId: Int, id: Int, name: String, email: String, body: String) {
        self.postId = postId
        self.id = id
        self.name = name
        self.email = email
        self.body = body
    }
}

@objc(CommentDB)
public class CommentDB: NSManagedObject {

}

extension CommentDB {
    @nonobjc public class func createFetchRequest() -> NSFetchRequest<CommentDB> {
        return NSFetchRequest<CommentDB>(entityName: "CommentDB")
    }

    @NSManaged public var postId: Int32
    @NSManaged public var id: Int32
    @NSManaged public var name: String
    @NSManaged public var email: String
    @NSManaged public var body: String
    
    static public func mapComments(input: [CommentDB]) -> [Comment] {
        return input.map { comment -> Comment in
            Comment(postId: Int(comment.postId), id: Int(comment.id), name: comment.name, email: comment.email, body: comment.body)
        }
    }
}
