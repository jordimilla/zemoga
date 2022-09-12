import Domain
import Data
import Presentation
import CoreData

public class AppAssembly {
    
    public static let postListFeature: ViewControllerProvider = {
        
        let useCase = FetchPostsListUseCase(repository: ServiceRepositoryAssembly.makeServiceRepository())
        
        let coreDataStoring = CoreDataStore.default
        
        return PostListAssembly(fetchPostListUseCase: useCase,
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
