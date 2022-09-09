import Foundation
import Domain
import UIKit

public class PostListAssembly {
    
    private let fetchPostListUseCase: FetchPostsListUseCase
    private let nextFeature: SingleParamFeatureProvider<Int>
    
    public init(fetchPostListUseCase: FetchPostsListUseCase,
                nextFeature: @escaping SingleParamFeatureProvider<Int>) {
        self.fetchPostListUseCase = fetchPostListUseCase
        self.nextFeature = nextFeature
    }
    
    public func build() -> UIViewController {
        PostListViewController(viewModel: makeViewModel())
    }
}

extension PostListAssembly {
    
    private func makeViewModel() -> PostListViewModel {
        PostListViewModel(fetchPostListUseCase: fetchPostListUseCase,
                          nextFeature: nextFeature)
    }
}
