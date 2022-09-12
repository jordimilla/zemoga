import Foundation
import Combine

public struct FetchPostFromStoredUseCase: CoreDataUseCase {
    typealias RequestValue = Void
    typealias ResponseValue = AnyPublisher<[PostDB], Error>
    let coreDataRepository: CoreDataRepository
  
    public init(coreDataRepository: CoreDataRepository) {
        self.coreDataRepository = coreDataRepository
    }
    
    public func execute(value: Void) -> AnyPublisher<[PostDB], Error> {
        return coreDataRepository.fetchPostFromStored()
    }
}




