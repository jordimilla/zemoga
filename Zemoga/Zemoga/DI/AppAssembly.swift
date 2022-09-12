import Domain
import Data
import Presentation
import CoreData

public class AppAssembly {
    
    public static let postListFeature: ViewControllerProvider = {
        
        let coreDataStoring = CoreDataStore.default
        let fetchPostListUseCase = FetchPostsListUseCase(repository: ServiceRepositoryAssembly.makeServiceRepository())
        let fetchPostFromStoredUseCase = FetchPostFromStoredUseCase(coreDataRepository: ServiceRepositoryAssembly.makeCoreDataRepository())
        let getPostDBUseCase = GetPostDBUseCase(coreDataRepository: ServiceRepositoryAssembly.makeCoreDataRepository())
        let updateFavoritePostUseCase = UpdateFavoritePostUseCase(coreDataRepository: ServiceRepositoryAssembly.makeCoreDataRepository())
        let createPostDBEntitiesUseCase = CreatePostDBEntitiesUseCase(coreDataRepository: ServiceRepositoryAssembly.makeCoreDataRepository())
        let deleteAllPostDBUseCase =  DeleteAllPostDBUseCase(coreDataRepository: ServiceRepositoryAssembly.makeCoreDataRepository())
        let deleteAllCommentDBUseCase =  DeleteAllCommentDBUseCase(coreDataRepository: ServiceRepositoryAssembly.makeCoreDataRepository())
        let deleteAllPostHasNotFavoriteUseCase =  DeleteAllPostHasNotFavoriteUseCase(coreDataRepository: ServiceRepositoryAssembly.makeCoreDataRepository())
        
        return PostListAssembly(fetchPostListUseCase: fetchPostListUseCase,
                                getPostDBUseCase: getPostDBUseCase,
                                updateFavoritePostUseCase: updateFavoritePostUseCase,
                                fetchPostFromStoredUseCase: fetchPostFromStoredUseCase,
                                createPostDBEntitiesUseCase: createPostDBEntitiesUseCase,
                                deleteAllPostDBUseCase: deleteAllPostDBUseCase,
                                deleteAllCommentDBUseCase: deleteAllCommentDBUseCase,
                                deleteAllPostHasNotFavoriteUseCase: deleteAllPostHasNotFavoriteUseCase,
                                nextFeature: detailPostFeature,
                                coreDataStore: coreDataStoring).build()
    }
    
    public static let detailPostFeature: SingleParamFeatureProvider<Post>  = { navigationController, post in
        
        let getDetailPostUseCase = GetDetailPostUseCase(repository: ServiceRepositoryAssembly.makeServiceRepository())
        let coreDataStoring = CoreDataStore.default
        
        return DetailPostAssembly(navigationController: navigationController,
                                  post: post,
                                  getDetailPostUseCase: getDetailPostUseCase,
                                  coreDataStore: coreDataStoring).build()
    }
}
