import XCTest
import Combine
@testable import Data
@testable import Domain

class ServiceDataSourceTest: XCTestCase {

    var dataSource: MockServiceDataRepository?
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        dataSource = MockServiceDataRepository()
        
        guard dataSource != nil else {
            XCTFail("DataSource is nil")
            return
        }
    }
    
    
    func test_fetchPostsListUseCase() {
        
        dataSource?.fetchPostsList()
            .sink { receiveCompletion in
                switch receiveCompletion {
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { posts in
                XCTAssertGreaterThan(posts.count, 0)
                for post in posts {
                    XCTAssertNotNil(post.id)
                }
            }
            .store(in: &cancellables)
    }
    
    func test_getDetailPostUseCase() {
        let postId = 1
        dataSource?.getDetailPost(id: postId)
            .sink { receiveCompletion in
                switch receiveCompletion {
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { comments in
                XCTAssertGreaterThan(comments.count, 0)
                for comment in comments {
                    XCTAssertNotNil(comment.id)
                }
            }
            .store(in: &cancellables)
    }

    static var allTests = [
        ("test_fetchPostsListUseCase", test_fetchPostsListUseCase),
        ("test_getDetailPostUseCase", test_getDetailPostUseCase)
    ]
}
