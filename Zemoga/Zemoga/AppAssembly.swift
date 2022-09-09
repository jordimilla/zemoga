import Domain
import Data
import Presentation

public class AppAssembly {
    
    public static let postListFeature: FeatureProvider = { navigationController in
        
        let useCase = FetchPostsListUseCase(repository: ServiceRepositoryAssembly.makeServiceRepository())
        
        return PostListAssembly(navigationController: navigationController, fetchPostListUseCase: useCase).build()
    }
}
