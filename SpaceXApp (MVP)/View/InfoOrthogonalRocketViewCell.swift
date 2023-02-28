import UIKit

final class InfoOrthogonalRocketViewCell: UICollectionViewCell {
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()
    
    private let valueLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private let cellFrame: UIView = {
        let cellFrame = UIView()
        cellFrame.translatesAutoresizingMaskIntoConstraints = false
        cellFrame.backgroundColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1)
        cellFrame.layer.cornerRadius = 35
        return cellFrame
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
        contentView.addSubview(cellFrame)
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueLabel)
    }
        
    private func loadAllViewLayout() {
        let constraints = [
            cellFrame.topAnchor.constraint(equalTo: self.topAnchor),
            cellFrame.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            cellFrame.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            cellFrame.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: cellFrame.centerYAnchor, constant: 12),
            titleLabel.centerXAnchor.constraint(equalTo: cellFrame.centerXAnchor),
            
            valueLabel.centerYAnchor.constraint(equalTo: cellFrame.centerYAnchor, constant: -12),
            valueLabel.centerXAnchor.constraint(equalTo: cellFrame.centerXAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
