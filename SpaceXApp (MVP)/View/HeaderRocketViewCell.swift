import UIKit
import Kingfisher

final class HeaderRocketsCollectionViewCell: UICollectionViewCell {
    var settingsButtonOnClick: (() -> Void)?
    
    private let rocketImageView: UIImageView = {
        let image = UIImage()
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Helvetica-Bold", size: 24)
        return label
    }()
    
    private let settingsButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "settingsButton")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        return button
    }()
    
    private let cellFrame: UIView = {
        let cellFrame = UIView()
        cellFrame.translatesAutoresizingMaskIntoConstraints = false
        cellFrame.backgroundColor = .black
        cellFrame.layer.cornerRadius = 40
        return cellFrame
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        settingsButton.addTarget(self, action: #selector(clickSettingsButton), for: .touchUpInside)
        setViews()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(imageURL: URL?, title: String) {
        rocketImageView.kf.setImage(with: imageURL)
        titleLabel.text = title
    }
    
    @objc private func clickSettingsButton() {
        settingsButtonOnClick?()
    }
    
    private func setViews() {
        contentView.addSubview(rocketImageView)
        contentView.addSubview(cellFrame)
        contentView.addSubview(titleLabel)
        contentView.addSubview(settingsButton)
    }
        
    private func setLayout() {
        let constraints = [
            rocketImageView.topAnchor.constraint(equalTo: self.topAnchor),
            rocketImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            rocketImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            rocketImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            cellFrame.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 100),
            cellFrame.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 100),
            cellFrame.leadingAnchor.constraint(equalTo: rocketImageView.leadingAnchor),
            cellFrame.trailingAnchor.constraint(equalTo: rocketImageView.trailingAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: cellFrame.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            
            settingsButton.centerXAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: -32),
            settingsButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
