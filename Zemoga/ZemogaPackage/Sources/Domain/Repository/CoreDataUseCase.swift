import Foundation

protocol CoreDataUseCase {
    var coreDataRepository: CoreDataRepository { get }
    
    init(coreDataRepository: CoreDataRepository)
}
