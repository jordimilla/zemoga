import Foundation
import Domain
import UIKit
import Combine

class DetailPostViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: DetailPostViewModel
    private var cancellables: Set<AnyCancellable> = []
    
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
        viewModel.getDetailPost(id: viewModel.idPost)
    }
    
    private func setupBindings() {

    }
}
