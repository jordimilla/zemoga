import Foundation
import Domain
import UIKit

public class PostListAssembly {
    
    private let navigationController: UINavigationController
    private let fetchPostListUseCase: FetchPostsListUseCase
    
    public init(navigationController: UINavigationController,
                fetchPostListUseCase: FetchPostsListUseCase) {
        self.navigationController = navigationController
        self.fetchPostListUseCase = fetchPostListUseCase
    }
    
    public func build() -> UIViewController {
        PostListViewController(viewModel: makeViewModel())
    }
}

extension PostListAssembly {
    
    private func makeViewModel() -> PostListViewModel {
        PostListViewModel(navigationController: navigationController,
                          fetchPostListUseCase: fetchPostListUseCase)
    }
}
