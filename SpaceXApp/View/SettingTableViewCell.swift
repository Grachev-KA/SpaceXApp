import UIKit

final class SettingTableViewCell: UITableViewCell {
    static let identifier = "cellSettingsView"
    private let userSettings = UserSettings()
    private var setting: Settings?
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl()
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentTintColor = .green
        sc.addTarget(self, action: #selector(handleSegmentedControlValueChanged), for: .valueChanged)
        return sc
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        loadAllView()
        loadAllViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        guard let setting = setting else { return }
        sender.selectedSegmentIndex == 0 ? userSettings.save(setting: setting.type, value: setting.units[0]) : userSettings.save(setting: setting.type, value: setting.units[1])
    }
    
    func setup(setting: Settings, selectedUnit: Settings.Units?) {
        self.setting = setting
        label.text = setting.type.rawValue
        
        if let selectedUnit = selectedUnit {
            segmentedControl.selectedSegmentIndex = setting.units.firstIndex(of: selectedUnit) ?? 0
        }
        
        for unit in setting.units {
            segmentedControl.insertSegment(withTitle: unit.rawValue, at: 1, animated: false)
        }
    }
    
    private func loadAllView() {
        contentView.addSubview(label)
        contentView.addSubview(segmentedControl)
    }
    
    private func loadAllViewLayout() {
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
