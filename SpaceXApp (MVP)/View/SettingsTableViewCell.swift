import UIKit

final class SettingsTableViewCell: UITableViewCell {
    var onSettingChanged: ((Int) -> Void)?
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl()
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.backgroundColor = UIColor.black
        sc.layer.borderColor = UIColor.white.cgColor
        sc.selectedSegmentTintColor = UIColor.white
        sc.layer.borderWidth = 1
        sc.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        sc.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        sc.addTarget(self, action: #selector(handleSegmentedControlValueChanged), for: .valueChanged)
        return sc
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .black
        setView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        onSettingChanged?(sender.selectedSegmentIndex)
    }
    
    func setupCell(setting: SettingsModel, selectedUnit: SettingsModel.Units?) {
        label.text = setting.type.rawValue

        for unit in setting.units {
            segmentedControl.insertSegment(withTitle: unit.rawValue, at: 1, animated: false)
        }
        
        if let selectedUnit = selectedUnit {
            segmentedControl.selectedSegmentIndex = setting.units.firstIndex(of: selectedUnit) ?? 0
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        segmentedControl.removeAllSegments()
    }
    
    private func setView() {
        contentView.addSubview(label)
        contentView.addSubview(segmentedControl)
    }
    
    private func setLayout() {
        let constraints = [
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            label.widthAnchor.constraint(equalToConstant: 200),
            
            segmentedControl.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            segmentedControl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            segmentedControl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            segmentedControl.widthAnchor.constraint(equalToConstant: 100)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
