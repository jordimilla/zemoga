import Foundation
import Domain
import UIKit
import Combine

final class PostListViewModel {
    
    private let fetchPostListUseCase: FetchPostsListUseCase
    private let nextFeature: SingleParamFeatureProvider<Int>
    
    private var cancellables = Set<AnyCancellable>()
    @Published private(set) var posts: [Post] = []
    
    init(fetchPostListUseCase: FetchPostsListUseCase,
         nextFeature: @escaping SingleParamFeatureProvider<Int>) {
        self.fetchPostListUseCase = fetchPostListUseCase
        self.nextFeature = nextFeature
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
    
    func goToDetailPost(navigationController: UINavigationController, idPost: Int) {
        let viewController = nextFeature(navigationController, idPost)
        navigationController.pushViewController(viewController, animated: true)
    }
}
