@testable import Domain
@testable import Presentation
@testable import Data
import Foundation
import Combine
import XCTest

class DetailPostViewModelTest: XCTestCase {
    
    var viewModel: DetailPostViewModel?
    var getDetailPostUseCase: GetDetailPostUseCase!
    var fetchCommentsFromStoredUseCase: FetchCommentsFromStoredUseCase!
    var createCommentDBEntitiesUseCase: CreateCommentDBEntitiesUseCase!
    
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    //MARK: - Setup
    
    override func setUpWithError() throws {
        let post = Post(userId: 0, id: 0, title: "0", body: "0")
        getDetailPostUseCase = GetDetailPostUseCase(repository: MockServiceRepository())
        
        fetchCommentsFromStoredUseCase = FetchCommentsFromStoredUseCase(coreDataRepository: MockCoreDataRepository())
        createCommentDBEntitiesUseCase = CreateCommentDBEntitiesUseCase(coreDataRepository: MockCoreDataRepository())
        
        viewModel = DetailPostViewModel(navigationController: UINavigationController(),
                                  post: post,
                                  getDetailPostUseCase: getDetailPostUseCase,
                                  fetchCommentsFromStoredUseCase: fetchCommentsFromStoredUseCase,
                                  createCommentDBEntitiesUseCase: createCommentDBEntitiesUseCase)
        
        guard viewModel != nil else {
            XCTFail("ViewModel is nil")
            return
        }
    }
    
    //MARK: - Tests
    func test_getComments() {
        let expectation = XCTestExpectation(description: self.description)
        
        viewModel?.$comments
            .sink(receiveValue: { comments in
                guard let comment = comments.last else {
                    return
                }
                XCTAssertNotNil(comment)
                XCTAssertNotNil(comment.id)
                XCTAssertEqual(comment.postId, 1)
                XCTAssertEqual(comment.id, 1)
                XCTAssertEqual(comment.email, "jordi@email.com")
                XCTAssertEqual(comment.body, "1")
                expectation.fulfill()
            })
            .store(in: &cancellable)
        
        viewModel?.getDetailPost()
        
        wait(for: [expectation], timeout: 1)
    }
    

    static var allTests = [
        ("test_getComments", test_getComments)
    ]
}
