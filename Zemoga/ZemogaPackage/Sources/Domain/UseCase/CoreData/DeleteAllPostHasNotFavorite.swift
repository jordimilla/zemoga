import Foundation
import Combine
import CoreData

public struct DeleteAllPostHasNotFavoriteUseCase: CoreDataUseCase {
    typealias RequestValue = Void
    typealias ResponseValue = AnyPublisher<NSBatchDeleteResult, Error>
    let coreDataRepository: CoreDataRepository
  
    public init(coreDataRepository: CoreDataRepository) {
        self.coreDataRepository = coreDataRepository
    }
    
    public func execute(value: Void) -> AnyPublisher<NSBatchDeleteResult, Error> {
        return coreDataRepository.deleteAllPostHasNotFavorite()
    }
}




