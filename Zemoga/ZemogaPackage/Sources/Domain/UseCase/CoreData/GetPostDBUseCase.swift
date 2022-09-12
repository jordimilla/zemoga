import Foundation
import Combine

public struct GetPostDBUseCase: CoreDataUseCase {
    typealias RequestValue = Int
    typealias ResponseValue = AnyPublisher<PostDB, Error>
    let coreDataRepository: CoreDataRepository
  
    public init(coreDataRepository: CoreDataRepository) {
        self.coreDataRepository = coreDataRepository
    }
    
    public func execute(value: Int) -> AnyPublisher<PostDB, Error> {
        return coreDataRepository.getPostDB(id: value)
    }
}


