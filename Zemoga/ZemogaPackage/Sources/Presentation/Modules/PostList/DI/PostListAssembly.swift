import Foundation
import Domain
import UIKit

public class PostListAssembly {
    
    private let fetchPostListUseCase: FetchPostsListUseCase
    private let nextFeature: SingleParamFeatureProvider<Post>
    private let coreDataStore: CoreDataStoring
    
    public init(fetchPostListUseCase: FetchPostsListUseCase,
                nextFeature: @escaping SingleParamFeatureProvider<Post>,
                coreDataStore: CoreDataStoring) {
        self.fetchPostListUseCase = fetchPostListUseCase
        self.nextFeature = nextFeature
        self.coreDataStore = coreDataStore
    }
    
    public func build() -> UIViewController {
        PostListViewController(viewModel: makeViewModel())
    }
}

extension PostListAssembly {
    
    private func makeViewModel() -> PostListViewModel {
        PostListViewModel(fetchPostListUseCase: fetchPostListUseCase,
                          nextFeature: nextFeature,
                          coreDataStore: coreDataStore)
    }
}
