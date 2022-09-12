import Domain

public class ServiceRepositoryAssembly {
    
    public static func makeServiceRepository() -> ServiceRepository {
        let dataSource = ServiceDataSource()
        let repository = ServiceRepositoryImpl(serviceDataSource: dataSource)
        
        return repository
    }
    
    public static func makeCoreDataRepository() -> CoreDataRepository {
        let coreDataStoring = CoreDataStore.default
        let repository = CoreDataRepositoryImpl(coreDataStore: coreDataStoring)
        
        return repository
    }
}
