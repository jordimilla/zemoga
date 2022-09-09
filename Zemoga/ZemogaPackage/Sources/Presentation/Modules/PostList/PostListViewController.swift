import Foundation
import Domain
import UIKit
import Combine

class PostListViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: PostListViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    let tableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView())
    
    // MARK: - Inits
    
    public init(viewModel: PostListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupBindings()
        viewModel.fetchPosts()
    }
    
    private func setupBindings() {
        viewModel.$posts
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
}

// MARK: - UITableViewDataSource

extension PostListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.indentifier, for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }
        let post:Post = viewModel.posts[indexPath.row]
        cell.setup(title: post.title)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension PostListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post:Post = viewModel.posts[indexPath.row]
        guard let navigationController = self.navigationController else { return }
        viewModel.goToDetailPost(navigationController: navigationController, idPost: post.id)
    }
}

// MARK: - CustomViewController

extension PostListViewController {
    public func setupViews() {
        title = "Posts"
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.indentifier)
    }

    public func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.safeAreaLayoutGuide.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.safeAreaLayoutGuide.rightAnchor)
    }
}
