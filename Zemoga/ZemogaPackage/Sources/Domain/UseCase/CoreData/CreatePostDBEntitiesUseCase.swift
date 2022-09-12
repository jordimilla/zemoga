import Foundation
import Combine

public struct CreatePostDBEntitiesUseCase: CoreDataUseCase {
    typealias RequestValue = [Post]
    let coreDataRepository: CoreDataRepository
    
    public init(coreDataRepository: CoreDataRepository) {
        self.coreDataRepository = coreDataRepository
    }
    
    public func execute(value: [Post]) {
        return coreDataRepository.createPostDBEntities(posts: value)
    }
}
