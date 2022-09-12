import Foundation

protocol CoreDataUseCase {
    var coreData: CoreDataRepository { get }
    
    init(coreData: CoreDataRepository)
}
