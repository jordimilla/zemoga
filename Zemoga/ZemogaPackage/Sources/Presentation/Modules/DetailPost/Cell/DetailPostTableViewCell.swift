import UIKit

public final class DetailPostTableViewCell: UITableViewCell {
    
    public static let indentifier = "DetailPostTableViewCell"
    
    private lazy var stackViewVertical: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 8
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .regular)
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13.0, weight: .regular)
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13.0, weight: .regular)
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(stackViewVertical)
        stackViewVertical.addArrangedSubview(titleLabel)
        stackViewVertical.addArrangedSubview(emailLabel)
        stackViewVertical.addArrangedSubview(bodyLabel)
        setupContraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContraints() {
        stackViewVertical.anchor(top: self.topAnchor,
                          left: self.leftAnchor,
                          bottom: self.bottomAnchor,
                          right: self.rightAnchor,
                          topConstant: 16,
                          leftConstant: 16,
                          bottomConstant: 16,
                          rightConstant: 16)
        
    }
    
    func setup(title: String, email: String, body: String) {
        titleLabel.text = "Name: \(title)"
        emailLabel.text = "Email: \(email)"
        bodyLabel.text = "Message: \(body)"
    }
}


