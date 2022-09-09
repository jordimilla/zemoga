import Foundation
import Combine
import Domain

public struct ServiceRepositoryImpl: ServiceRepository {

    private let serviceDataSource: ServiceDataSource
    
    public init(serviceDataSource: ServiceDataSource) {
        self.serviceDataSource = serviceDataSource
    }
    
    public func fetchPostsList() -> AnyPublisher<[Post], Error> {
        serviceDataSource.fetchPostsList()
    }
    
    public func getDetailPost(id: Int) -> AnyPublisher<[Comment], Error> {
        serviceDataSource.getDetailPost(id: id)
    }
}
