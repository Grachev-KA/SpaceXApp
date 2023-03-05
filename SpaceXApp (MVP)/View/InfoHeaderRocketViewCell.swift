import UIKit

final class InfoHeaderRocketViewCell: UICollectionReusableView {
    private let headerInfoVertical: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setViews()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(title: String) {
        headerInfoVertical.text = title
    }
        
    private func setViews() {
        addSubview(headerInfoVertical)
    }
        
    private func setLayout() {
        let constraints = [
            headerInfoVertical.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            headerInfoVertical.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            headerInfoVertical.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            headerInfoVertical.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
