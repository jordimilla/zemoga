import Foundation
import Combine
import CoreData

public struct UpdateFavoritePostUseCase: CoreDataUseCase {
    typealias RequestValue = PostDB
    typealias ResponseValue = AnyPublisher<Bool, Error>
    let coreDataRepository: CoreDataRepository
  
    public init(coreDataRepository: CoreDataRepository) {
        self.coreDataRepository = coreDataRepository
    }
    
    public func execute(value: PostDB) -> AnyPublisher<Bool, Error> {
        return coreDataRepository.updateFavoritePost(post: value)
    }
}




