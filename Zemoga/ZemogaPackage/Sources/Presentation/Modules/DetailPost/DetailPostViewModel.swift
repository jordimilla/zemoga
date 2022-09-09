import Foundation
import Domain
import UIKit
import Combine

final class DetailPostViewModel {
    
    let navigationController: UINavigationController
    let idPost: Int
    private let getDetailPostUseCase: GetDetailPostUseCase
    private var cancellables = Set<AnyCancellable>()

    
    init(navigationController: UINavigationController,
         idPost: Int,
         getDetailPostUseCase: GetDetailPostUseCase) {
        self.navigationController = navigationController
        self.idPost = idPost
        self.getDetailPostUseCase = getDetailPostUseCase
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
}
