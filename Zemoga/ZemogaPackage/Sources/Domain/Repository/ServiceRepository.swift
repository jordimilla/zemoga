import Foundation
import Combine

public protocol ServiceRepository {
    func fetchPostsList() -> AnyPublisher<[Post], Error>
    func getDetailPost(id: Int) -> AnyPublisher<[Comment], Error>
}
