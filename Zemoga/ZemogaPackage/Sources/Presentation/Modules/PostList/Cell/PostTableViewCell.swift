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
    
    var hasFavorite: Bool = false
    var valueFavoriteChanged:((Bool) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(titleLabel)
        setupContraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func handleMarkAsFavorite() {
        self.hasFavorite = !self.hasFavorite
        setStar(hasFavorite: self.hasFavorite)
        valueFavoriteChanged?(self.hasFavorite)
    }
    
    private func setupContraints() {
        titleLabel.anchor(top: self.topAnchor,
                          left: self.leftAnchor,
                          bottom: self.bottomAnchor,
                          right: self.rightAnchor,
                          topConstant: 16,
                          leftConstant: 16,
                          bottomConstant: 16,
                          rightConstant: 50)
        
    }
    
    func setup(title: String, hasFavorite: Bool) {
        self.hasFavorite = hasFavorite
        titleLabel.text = title
        setStar(hasFavorite: self.hasFavorite)
    }
    
    func setCallback(callback:@escaping (Bool) -> Void) {
        valueFavoriteChanged = callback
     }
    
    func setStar(hasFavorite: Bool) {
        let starButton = UIButton(type: .system)
        if hasFavorite {
            starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            starButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        starButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        accessoryView = starButton
        starButton.addTarget(self, action: #selector(handleMarkAsFavorite), for: .touchUpInside)
    }
}


