import XCTest
import Combine
@testable import Domain

final class CoreDataUsesCasesTest: XCTestCase {
    
    var getPostDBUseCase: GetPostDBUseCase?
    var deletePostDBUseCase: DeletePostDBUseCase?
    
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    //MARK: - Setup
    
    override func setUpWithError() throws {
        
        self.getPostDBUseCase = GetPostDBUseCase(coreDataRepository: MockCoreDataRepository())
        self.deletePostDBUseCase = DeletePostDBUseCase(coreDataRepository: MockCoreDataRepository())
        
        guard self.getPostDBUseCase != nil else {
            XCTFail("Usecase is nil")
            return
        }
    }
    
    //MARK: - Tests
    func test_getPostDBUseCase() {
        
        getPostDBUseCase?.execute(value: 1)
            .sink { receiveCompletion in
                switch receiveCompletion {
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { post in
                XCTAssertTrue(true)
            }
            .store(in: &cancellables)
    }
    
    func test_deletePostDBUseCase() {
        let post = Post(userId: 0, id: 0, title: "0", body: "body")
        deletePostDBUseCase?.execute(value: post)
            .sink { receiveCompletion in
                switch receiveCompletion {
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { post in
                XCTAssertTrue(true)
            }
            .store(in: &cancellables)
    }
    
    static var allTests = [
        ("test_getPostDBUseCase", test_getPostDBUseCase),
        ("test_deletePostDBUseCase", test_deletePostDBUseCase)
    ]
}
