import Foundation
import Combine
import CoreData

public struct DeletePostDBUseCase: CoreDataUseCase {
    typealias RequestValue = Post
    typealias ResponseValue = AnyPublisher<NSBatchDeleteResult, Error>
    let coreDataRepository: CoreDataRepository
  
    public init(coreDataRepository: CoreDataRepository) {
        self.coreDataRepository = coreDataRepository
    }
    
    public func execute(value: Post) -> AnyPublisher<NSBatchDeleteResult, Error> {
        return coreDataRepository.deletePost(post: value)
    }
}



