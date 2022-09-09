import Foundation
import Domain
import UIKit

public class DetailPostAssembly {
    
    private let navigationController: UINavigationController
    private let idPost: Int
    private let getDetailPostUseCase: GetDetailPostUseCase
    private let getCommentsPostUseCase: GetCommentsPostUseCase
    
    public init(navigationController: UINavigationController,
                idPost: Int,
                getDetailPostUseCase: GetDetailPostUseCase,
                getCommentsPostUseCase: GetCommentsPostUseCase) {
        self.navigationController = navigationController
        self.idPost = idPost
        self.getDetailPostUseCase = getDetailPostUseCase
        self.getCommentsPostUseCase = getCommentsPostUseCase
    }
    
    public func build() -> UIViewController {
        DetailPostViewController(viewModel: makeViewModel())
    }
}

extension DetailPostAssembly {
    
    private func makeViewModel() -> DetailPostViewModel {
       DetailPostViewModel(navigationController: navigationController,
                           idPost: idPost,
                           getDetailPostUseCase: getDetailPostUseCase,
                           getCommentsPostUseCase: getCommentsPostUseCase)
    }
}

