import Foundation
import CoreData

public struct Post: Codable {
    public let userId: Int
    public let id: Int
    public let title: String
    public let body: String
    public var hasFavorite: Bool?
    
    public init(userId: Int, id: Int, title: String, body: String, hasFavorite: Bool? = false) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
        self.hasFavorite = hasFavorite
    }
}



@objc(PostDB)
public class PostDB: NSManagedObject {

}

extension PostDB {
    @nonobjc public class func createFetchRequest() -> NSFetchRequest<PostDB> {
        return NSFetchRequest<PostDB>(entityName: "PostDB")
    }

    @NSManaged public var userId: Int32
    @NSManaged public var id: Int32
    @NSManaged public var title: String
    @NSManaged public var body: String
    @NSManaged public var hasFavorite: Bool
    
    static public func mapPosts(input: [PostDB]) -> [Post] {
        return input.map { post -> Post in
            Post(userId: Int(post.userId), id: Int(post.id), title: post.title, body: post.body, hasFavorite: post.hasFavorite)
        }
    }
}
