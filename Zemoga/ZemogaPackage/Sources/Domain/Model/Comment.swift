import Foundation

public struct Comment: Codable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
