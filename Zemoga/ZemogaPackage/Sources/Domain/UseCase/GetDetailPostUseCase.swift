import Foundation
import Combine

public struct GetDetailPostUseCase: ServiceUseCase {
    typealias RequestValue = Int
    typealias ResponseValue = AnyPublisher<Post, Error>
    let repository: ServiceRepository
    
    public init(repository: ServiceRepository) {
        self.repository = repository
    }
    
    public func execute(value: Int) -> AnyPublisher<Post, Error> {
        return repository.getDetailPost(id: value)
    }
}
