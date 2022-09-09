import Domain
import Data
import Presentation

public class AppAssembly {
    
    public static let postListFeature: ViewControllerProvider = {
        
        let useCase = FetchPostsListUseCase(repository: ServiceRepositoryAssembly.makeServiceRepository())
        
        return PostListAssembly(fetchPostListUseCase: useCase, nextFeature: detailPostFeature).build()
    }
    
    public static let detailPostFeature: SingleParamFeatureProvider<Int>  = { navigationController, id in
        
        let getDetailPostUseCase = GetDetailPostUseCase(repository: ServiceRepositoryAssembly.makeServiceRepository())
        
        return DetailPostAssembly(navigationController: navigationController,
                                  idPost: id,
                                  getDetailPostUseCase: getDetailPostUseCase).build()
    }
}
