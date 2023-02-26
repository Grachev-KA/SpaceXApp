import UIKit

final class SettingsViewController: UIViewController {
    lazy private var presenter = SettingsPresenter(view: self)
    private var availableSettings = [SettingsModel]()
    private var selectedUnit: SettingsModel.Units?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.reuseIdentifier)
        tableView.backgroundColor = .black
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = tableView
        view.backgroundColor = .black
        tableView.dataSource = self
        tableView.delegate = self
        presenter.getSettings()
        tableView.reloadData()
        setLayout()
    }
    
    private func setLayout() {
        let constraints = [
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        availableSettings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.reuseIdentifier, for: indexPath)
        let setting = availableSettings[indexPath.row]
        presenter.getUserSettings(setting: setting)
        (cell as? SettingsTableViewCell)?.setupCell(setting: setting, selectedUnit: selectedUnit)
        cell.selectionStyle = .none
        
        (cell as? SettingsTableViewCell)?.onSettingChanged = { selectedSegmentIndex in
            self.presenter.saveUserSettings(setting: setting, selectedSegmentIndex: selectedSegmentIndex)
        }
        
        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}

// MARK: - SettingsViewProtocol

extension SettingsViewController: SettingsViewProtocol {
    func present(availableSettings: [SettingsModel]) {
        self.availableSettings = availableSettings
    }
    
    func present(selectedUnit: SettingsModel.Units?) {
        self.selectedUnit = selectedUnit
    }
}
