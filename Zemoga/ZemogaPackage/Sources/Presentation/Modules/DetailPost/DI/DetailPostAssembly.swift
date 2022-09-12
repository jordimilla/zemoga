import Foundation
import Domain
import UIKit

public class DetailPostAssembly {
    
    private let navigationController: UINavigationController
    private let post: Post
    private let getDetailPostUseCase: GetDetailPostUseCase
    private let coreDataStore: CoreDataStoring
    
    public init(navigationController: UINavigationController,
                post: Post,
                getDetailPostUseCase: GetDetailPostUseCase,
                coreDataStore: CoreDataStoring) {
        self.navigationController = navigationController
        self.post = post
        self.getDetailPostUseCase = getDetailPostUseCase
        self.coreDataStore = coreDataStore
    }
    
    public func build() -> UIViewController {
        DetailPostViewController(viewModel: makeViewModel())
    }
}

extension DetailPostAssembly {
    
    private func makeViewModel() -> DetailPostViewModel {
       DetailPostViewModel(navigationController: navigationController,
                           post: post,
                           getDetailPostUseCase: getDetailPostUseCase,
                           coreDataStore: coreDataStore)
    }
}

