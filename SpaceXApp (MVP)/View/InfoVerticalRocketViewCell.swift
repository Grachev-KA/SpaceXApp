import UIKit

final class InfoVerticalRocketViewCell: UICollectionViewCell {
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let valueLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadAllView()
        loadAllViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(title: String, value: String) {
        titleLabel.text = title
        valueLabel.text = value
    }
        
    private func loadAllView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueLabel)
    }
        
    private func loadAllViewLayout() {
        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            
            valueLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            valueLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            valueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            valueLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
