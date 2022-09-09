import Foundation
import Domain
import UIKit
import Combine

final class PostListViewModel {
    
    let navigationController: UINavigationController
    private let fetchPostListUseCase: FetchPostsListUseCase
    
    private var cancellables = Set<AnyCancellable>()
    @Published private(set) var posts: [Post] = []
    
    init(navigationController: UINavigationController,
         fetchPostListUseCase: FetchPostsListUseCase) {
        self.navigationController = navigationController
        self.fetchPostListUseCase = fetchPostListUseCase
    }
    
    func fetchPosts() {
        fetchPostListUseCase.execute(value: ())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }, receiveValue: { [weak self] items in
                self?.posts = items
            })
            .store(in: &cancellables)
    }
}
