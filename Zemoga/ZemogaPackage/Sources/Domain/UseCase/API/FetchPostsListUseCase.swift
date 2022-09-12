import Foundation
import Combine

public struct FetchPostsListUseCase: ServiceUseCase {
    typealias RequestValue = Void
    typealias ResponseValue = AnyPublisher<[Post], Error>
    let repository: ServiceRepository
    
    public init(repository: ServiceRepository) {
        self.repository = repository
    }
    
    public func execute(value: Void) -> AnyPublisher<[Post], Error> {
        return repository.fetchPostsList()
    }
}
