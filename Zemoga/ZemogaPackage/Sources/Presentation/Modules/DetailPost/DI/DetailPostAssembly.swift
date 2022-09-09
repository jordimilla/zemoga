import Foundation
import Domain
import UIKit

public class DetailPostAssembly {
    
    private let navigationController: UINavigationController
    private let idPost: Int
    private let getDetailPostUseCase: GetDetailPostUseCase
    
    public init(navigationController: UINavigationController,
                idPost: Int,
                getDetailPostUseCase: GetDetailPostUseCase) {
        self.navigationController = navigationController
        self.idPost = idPost
        self.getDetailPostUseCase = getDetailPostUseCase
    }
    
    public func build() -> UIViewController {
        DetailPostViewController(viewModel: makeViewModel())
    }
}

extension DetailPostAssembly {
    
    private func makeViewModel() -> DetailPostViewModel {
       DetailPostViewModel(navigationController: navigationController,
                           idPost: idPost,
                           getDetailPostUseCase: getDetailPostUseCase)
    }
}

