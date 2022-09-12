import Foundation
import Domain
import UIKit

public class PostListAssembly {
    
    private let fetchPostListUseCase: FetchPostsListUseCase
    private let getPostDBUseCase: GetPostDBUseCase
    private let updateFavoritePostUseCase: UpdateFavoritePostUseCase
    private let fetchPostFromStoredUseCase: FetchPostFromStoredUseCase
    private let createPostDBEntitiesUseCase: CreatePostDBEntitiesUseCase
    private let deleteAllPostDBUseCase: DeleteAllPostDBUseCase
    private let deleteAllCommentDBUseCase: DeleteAllCommentDBUseCase
    private let deleteAllPostHasNotFavoriteUseCase: DeleteAllPostHasNotFavoriteUseCase
    private let nextFeature: SingleParamFeatureProvider<Post>
    private let coreDataStore: CoreDataStoring
    
    public init(fetchPostListUseCase: FetchPostsListUseCase,
                getPostDBUseCase: GetPostDBUseCase,
                updateFavoritePostUseCase: UpdateFavoritePostUseCase,
                fetchPostFromStoredUseCase: FetchPostFromStoredUseCase,
                createPostDBEntitiesUseCase: CreatePostDBEntitiesUseCase,
                deleteAllPostDBUseCase: DeleteAllPostDBUseCase,
                deleteAllCommentDBUseCase: DeleteAllCommentDBUseCase,
                deleteAllPostHasNotFavoriteUseCase: DeleteAllPostHasNotFavoriteUseCase,
                nextFeature: @escaping SingleParamFeatureProvider<Post>,
                coreDataStore: CoreDataStoring) {
        self.fetchPostListUseCase = fetchPostListUseCase
        self.getPostDBUseCase = getPostDBUseCase
        self.updateFavoritePostUseCase = updateFavoritePostUseCase
        self.fetchPostFromStoredUseCase = fetchPostFromStoredUseCase
        self.createPostDBEntitiesUseCase = createPostDBEntitiesUseCase
        self.deleteAllPostDBUseCase = deleteAllPostDBUseCase
        self.deleteAllPostHasNotFavoriteUseCase = deleteAllPostHasNotFavoriteUseCase
        self.deleteAllCommentDBUseCase = deleteAllCommentDBUseCase
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
                          getPostDBUseCase: getPostDBUseCase,
                          updateFavoritePostUseCase: updateFavoritePostUseCase,
                          fetchPostFromStoredUseCase: fetchPostFromStoredUseCase,
                          createPostDBEntitiesUseCase: createPostDBEntitiesUseCase,
                          deleteAllPostDBUseCase: deleteAllPostDBUseCase,
                          deleteAllPostHasNotFavoriteUseCase: deleteAllPostHasNotFavoriteUseCase,
                          deleteAllCommentDBUseCase: deleteAllCommentDBUseCase,
                          nextFeature: nextFeature,
                          coreDataStore: coreDataStore)
    }
}
