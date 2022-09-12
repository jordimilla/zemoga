import UIKit
import Domain

public final class PostTableViewCell: UITableViewCell {
    
    public static let indentifier = "PostTableViewCell"

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .regular)
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    var hasFavorite: Bool?
    var valueFavoriteChanged:((Bool) -> Void)?
    var deleteChanged:(() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(titleLabel)
        setupContraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func handleMarkAsFavorite() {
        self.hasFavorite = !(self.hasFavorite ?? false)
        setButtons(hasFavorite: self.hasFavorite ?? false)
        valueFavoriteChanged?(self.hasFavorite ?? false)
    }
    
    @objc private func handleDelete() {
       deleteChanged?()
    }
    
    private func setupContraints() {
        titleLabel.anchor(top: self.topAnchor,
                          left: self.leftAnchor,
                          bottom: self.bottomAnchor,
                          right: self.rightAnchor,
                          topConstant: 16,
                          leftConstant: 16,
                          bottomConstant: 16,
                          rightConstant: 90)
        
    }
    
    func setup(title: String, hasFavorite: Bool) {
        self.hasFavorite = hasFavorite
        titleLabel.text = title
        setButtons(hasFavorite: self.hasFavorite ?? false)
    }
    
    func setCallback(callback:@escaping (Bool) -> Void) {
        valueFavoriteChanged = callback
     }
    
    func setDeleteCallback(callback:@escaping () -> Void) {
        deleteChanged = callback
     }
    
    func setButtons(hasFavorite: Bool) {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 90, height: 50)
        let starButton = UIButton(type: .system)
        let deleteButton = UIButton(type: .system)
        deleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
        deleteButton.frame = CGRect(x: 60, y: 0, width: 50, height: 50)
        if hasFavorite {
            starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            starButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        starButton.frame = CGRect(x:20, y: 0, width: 50, height: 50)
        view.addSubview(starButton)
        view.addSubview(deleteButton)
        accessoryView = view
        starButton.addTarget(self, action: #selector(handleMarkAsFavorite), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(handleDelete), for: .touchUpInside)
    }
}


