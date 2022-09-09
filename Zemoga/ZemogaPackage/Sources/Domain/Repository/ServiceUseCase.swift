import Foundation
import Combine

protocol ServiceUseCase {
    associatedtype RequestValue
    associatedtype ResponseValue
    var repository: ServiceRepository { get }
    
    init(repository: ServiceRepository)
    func execute(value: RequestValue) -> ResponseValue
}

