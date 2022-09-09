import Foundation
import Domain
import UIKit
import Combine

class PostListViewController: UIViewController {
    
    var viewModel: PostListViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    public init(viewModel: PostListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        viewModel.fetchPosts()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
    }
    
    private func setupBindings() {
        viewModel.$posts
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                print(self?.viewModel.posts)
            }
            .store(in: &cancellables)
    }
}
