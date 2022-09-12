import Foundation
import Combine

public struct CreateCommentDBEntitiesUseCase: CoreDataUseCase {
    typealias RequestValue = [Comment]
    let coreDataRepository: CoreDataRepository
    
    public init(coreDataRepository: CoreDataRepository) {
        self.coreDataRepository = coreDataRepository
    }
    
    public func execute(value: [Comment]) {
        return coreDataRepository.createCommentDBEntities(comments: value)
    }
}
