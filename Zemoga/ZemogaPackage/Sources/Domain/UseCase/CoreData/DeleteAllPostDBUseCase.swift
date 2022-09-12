import Foundation
import Combine

public struct DeleteAllPostDBUseCase: CoreDataUseCase {
    let coreDataRepository: CoreDataRepository
    
    public init(coreDataRepository: CoreDataRepository) {
        self.coreDataRepository = coreDataRepository
    }
    
    public func execute() {
        return coreDataRepository.deleteAllPost()
    }
}
