import Foundation
import Combine
@testable import Domain

public struct MockServiceDataRepository: ServiceRepository {
    public func fetchPostsList() -> AnyPublisher<[Post], Error> {
        let mockedListPost = [
            Post(userId: 0, id: 0, title: "0", body: "1"),
            Post(userId: 1, id: 2, title: "1", body: "1")
        ]
        
        return Just(mockedListPost)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    public func getDetailPost(id: Int) -> AnyPublisher<[Comment], Error> {
        let mockedListComment = [
            Comment(postId: 0, id: 0, name: "0", email: "0", body: "0"),
            Comment(postId: 1, id: 1, name: "1", email: "1", body: "1")
        ]
        
        return Just(mockedListComment)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
