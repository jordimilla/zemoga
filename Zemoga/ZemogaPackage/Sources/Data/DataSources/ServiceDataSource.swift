import Foundation
import Combine
import Domain

public struct ServiceDataSource: ServiceRepository {

    public init() {}
    
    public func fetchPostsList() -> AnyPublisher<[Post], Error> {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            fatalError("Invalid URL")
        }

        return URLSession.shared.dataTaskPublisher(for: url).map { $0.data }
        .decode(type: [Post].self, decoder: JSONDecoder())
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }

    public func getDetailPost(id: Int) -> AnyPublisher<Post, Error> {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            fatalError("Invalid URL")
        }

        return URLSession.shared.dataTaskPublisher(for: url).map { $0.data }
        .decode(type: Post.self, decoder: JSONDecoder())
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }

    public func getComments(id: Int) -> AnyPublisher<[Comment], Error> {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            fatalError("Invalid URL")
        }

        return URLSession.shared.dataTaskPublisher(for: url).map { $0.data }
        .decode(type: [Comment].self, decoder: JSONDecoder())
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
