import UIKit

final class LaunchViewCell: UITableViewCell {
    private let cellFrame: UIView = {
        let cellFrame = UIView()
        cellFrame.translatesAutoresizingMaskIntoConstraints = false
        cellFrame.backgroundColor = UIColor(red: 0.11, green: 0.10, blue: 0.11, alpha: 1)
        cellFrame.layer.cornerRadius = 15
        return cellFrame
    }()
    
    private let nameLaunch: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let dateLaunch: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    private let imageLaunch: UIImageView = {
        let image = UIImage()
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setViews()
        setLayout()
        
        contentView.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(name: String, dateUtc: String, imageLaunchStatus: UIImage?) {
        nameLaunch.text = name
        dateLaunch.text = dateUtc
        imageLaunch.image = imageLaunchStatus
    }
    
    private func setViews() {
        contentView.addSubview(cellFrame)
        contentView.addSubview(nameLaunch)
        contentView.addSubview(dateLaunch)
        contentView.addSubview(imageLaunch)
    }
    
    private func setLayout() {
        let constraints = [
            cellFrame.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            cellFrame.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            cellFrame.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            cellFrame.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            
            nameLaunch.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            nameLaunch.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 70),
            nameLaunch.widthAnchor.constraint(equalToConstant: 200),
            
            dateLaunch.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            dateLaunch.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 70),
            dateLaunch.widthAnchor.constraint(equalToConstant: 200),
            
            imageLaunch.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            imageLaunch.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            imageLaunch.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -70),
            imageLaunch.widthAnchor.constraint(equalToConstant: 30)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
