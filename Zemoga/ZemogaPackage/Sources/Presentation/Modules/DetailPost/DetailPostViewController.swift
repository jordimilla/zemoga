import Foundation
import Domain
import UIKit
import Combine

class DetailPostViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: DetailPostViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    let tableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView())
    
    // MARK: - Inits
    
    public init(viewModel: DetailPostViewModel) {
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
        viewModel.getDetailPost(id: viewModel.idPost)
    }
    
    private func setupBindings() {
        viewModel.$comments
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
}

// MARK: - UITableViewDataSource

extension DetailPostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailPostTableViewCell.indentifier, for: indexPath) as? DetailPostTableViewCell else {
            return UITableViewCell()
        }
        let comment:Comment = viewModel.comments[indexPath.row]
        cell.setup(title: comment.name, email: comment.email, body: comment.body)
        return cell
    }
}

// MARK: - CustomViewController

extension DetailPostViewController {
    public func setupViews() {
        title = "Details"
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.register(DetailPostTableViewCell.self, forCellReuseIdentifier: DetailPostTableViewCell.indentifier)
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
