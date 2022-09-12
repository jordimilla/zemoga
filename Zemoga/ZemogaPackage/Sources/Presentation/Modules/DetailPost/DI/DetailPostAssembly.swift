import Foundation
import Domain
import UIKit

public class DetailPostAssembly {
    
    private let navigationController: UINavigationController
    private let post: Post
    private let getDetailPostUseCase: GetDetailPostUseCase
    private let fetchCommentsFromStoredUseCase: FetchCommentsFromStoredUseCase
    private let createCommentDBEntitiesUseCase: CreateCommentDBEntitiesUseCase
    
    public init(navigationController: UINavigationController,
                post: Post,
                getDetailPostUseCase: GetDetailPostUseCase,
                fetchCommentsFromStoredUseCase: FetchCommentsFromStoredUseCase,
                createCommentDBEntitiesUseCase: CreateCommentDBEntitiesUseCase) {
        self.navigationController = navigationController
        self.post = post
        self.getDetailPostUseCase = getDetailPostUseCase
        self.fetchCommentsFromStoredUseCase = fetchCommentsFromStoredUseCase
        self.createCommentDBEntitiesUseCase = createCommentDBEntitiesUseCase
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
                            fetchCommentsFromStoredUseCase: fetchCommentsFromStoredUseCase,
                            createCommentDBEntitiesUseCase: createCommentDBEntitiesUseCase)
    }
}

