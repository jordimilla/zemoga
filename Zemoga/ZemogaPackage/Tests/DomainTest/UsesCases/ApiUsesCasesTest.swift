import XCTest
import Combine
@testable import Domain

final class ApiUsesCasesTest: XCTestCase {
    
    var fetchPostsListUseCase: FetchPostsListUseCase?
    var getDetailPostUseCase: GetDetailPostUseCase?
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    //MARK: - Setup
    
    override func setUpWithError() throws {
        
        self.fetchPostsListUseCase = FetchPostsListUseCase(repository: MockServiceRepository())
        self.getDetailPostUseCase = GetDetailPostUseCase(repository: MockServiceRepository())
        
        guard self.fetchPostsListUseCase != nil else {
            XCTFail("Usecase is nil")
            return
        }
    }
    
    //MARK: - Tests
    func test_fetchPostsListUseCase() {
        
        fetchPostsListUseCase?.execute(value: ())
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
        getDetailPostUseCase?.execute(value: (postId))
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
