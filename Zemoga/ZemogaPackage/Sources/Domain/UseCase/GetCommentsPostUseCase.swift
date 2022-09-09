import Foundation
import Combine

public struct GetCommentsPostUseCase: ServiceUseCase {
    typealias RequestValue = Int
    typealias ResponseValue = AnyPublisher<[Comment], Error>
    let repository: ServiceRepository
    
    public init(repository: ServiceRepository) {
        self.repository = repository
    }
    
    public func execute(value: Int) -> AnyPublisher<[Comment], Error> {
        return repository.getComments(id: value)
    }
}
