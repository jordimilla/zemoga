import Foundation
import Combine

public struct FetchCommentsFromStoredUseCase: CoreDataUseCase {
    typealias RequestValue = Post
    typealias ResponseValue = AnyPublisher<[CommentDB], Error>
    let coreDataRepository: CoreDataRepository
  
    public init(coreDataRepository: CoreDataRepository) {
        self.coreDataRepository = coreDataRepository
    }
    
    public func execute(value: Post) -> AnyPublisher<[CommentDB], Error> {
        return coreDataRepository.fetchCommentsFromStored(post: value)
    }
}
