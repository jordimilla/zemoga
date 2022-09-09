import Domain

public class ServiceRepositoryAssembly {
    
    public static func makeServiceRepository() -> ServiceRepository {
        let dataSource = ServiceDataSource()
        let repository = ServiceRepositoryImpl(serviceDataSource: dataSource)
        
        return repository
    }
}
