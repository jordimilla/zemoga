import Foundation
import Domain
import UIKit
import Combine

class PostListViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: PostListViewModel
    var posts: [Post] = []
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
        viewModel.fetchPostFromStored()
    }
    
    private func setupBindings() {
        viewModel.$posts
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                self?.posts = items
                self?.sortList()
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    func sortList() {
        self.posts.sort { $0.hasFavorite ?? true && !($1.hasFavorite ?? false) }
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension PostListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.indentifier, for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }
        let post:Post = posts[indexPath.row]
        cell.setup(title: post.title, hasFavorite: post.hasFavorite ?? false)
        cell.setCallback(callback: {[unowned self] (boolValue:Bool) in
            viewModel.setFavoritePost(id: post.id)
            sortList()
        })
        return cell
    }
}

// MARK: - UITableViewDelegate

extension PostListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post:Post = posts[indexPath.row]
        guard let navigationController = self.navigationController else { return }
        viewModel.goToDetailPost(navigationController: navigationController, post: post)
    }
}

// MARK: - CustomViewController

extension PostListViewController {
    public func setupViews() {
        title = "Posts"
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelectionDuringEditing = false
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.indentifier)
        
        let add = UIBarButtonItem(title: "API", style: .plain, target: self, action: #selector(apiTapped))
        let play = UIBarButtonItem(title: "Remove", style: .plain, target: self, action: #selector(removeTapped))

        navigationItem.rightBarButtonItems = [add, play]
    }

    public func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.safeAreaLayoutGuide.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.safeAreaLayoutGuide.rightAnchor)
    }
    
    @objc private func removeTapped() {
        viewModel.deleteAllPostHasNotFavorite()
    }
    
    @objc private func apiTapped() {
        viewModel.fetchPosts()
    }
}
