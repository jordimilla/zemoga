import Foundation
import Domain
import UIKit
import Combine

final class DetailPostViewModel {
    
    let navigationController: UINavigationController
    let idPost: Int
    private let getDetailPostUseCase: GetDetailPostUseCase
    private let getCommentsPostUseCase: GetCommentsPostUseCase
    
    private var cancellables = Set<AnyCancellable>()

    
    init(navigationController: UINavigationController,
         idPost: Int,
         getDetailPostUseCase: GetDetailPostUseCase,
         getCommentsPostUseCase: GetCommentsPostUseCase) {
        self.navigationController = navigationController
        self.idPost = idPost
        self.getDetailPostUseCase = getDetailPostUseCase
        self.getCommentsPostUseCase = getCommentsPostUseCase
    }
    
    func getDetailPost(id: Int) {
        getDetailPostUseCase.execute(value: (id))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }, receiveValue: { [weak self] items in
   
            })
            .store(in: &cancellables)
    }
    
    func getCommentsPost(id: Int) {
        getCommentsPostUseCase.execute(value: (id))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }, receiveValue: { [weak self] items in
   
            })
            .store(in: &cancellables)
    }
}
