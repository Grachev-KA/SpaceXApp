import UIKit

final class ButtonRocketViewCell: UICollectionViewCell {
    var launchesButtonOnClick: (() -> Void)?
    
    private let launchesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Посмотреть запуски", for: .normal)
        return button
    }()
    
    private let cellFrame: UIView = {
        let cellFrame = UIView()
        cellFrame.translatesAutoresizingMaskIntoConstraints = false
        cellFrame.backgroundColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1)
        cellFrame.layer.cornerRadius = 15
        return cellFrame
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        launchesButton.addTarget(self, action: #selector(clickLaunchesButton), for: .touchUpInside)
        
        loadAllView()
        loadAllViewLayout()
        
        contentView.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func clickLaunchesButton() {
        launchesButtonOnClick?()
    }
    
    private func loadAllView() {
        contentView.addSubview(cellFrame)
        contentView.addSubview(launchesButton)
    }
    
    private func loadAllViewLayout() {
        let constraints = [
            cellFrame.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            cellFrame.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            cellFrame.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            cellFrame.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            
            launchesButton.centerXAnchor.constraint(equalTo: cellFrame.centerXAnchor),
            launchesButton.centerYAnchor.constraint(equalTo: cellFrame.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
