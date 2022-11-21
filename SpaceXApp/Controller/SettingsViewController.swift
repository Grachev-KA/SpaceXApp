import UIKit

final class SettingsViewController: UIViewController {
    private let userSettings = UserSettings()
    
    private let settingsView: SettingsView = {
        let view = SettingsView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = settingsView
        view.backgroundColor = .darkGray
        settingsView.tableView.dataSource = self
        settingsView.tableView.delegate = self
        settingsView.tableView.reloadData()
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Settings.availableSettings().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath)
        let setting = Settings.availableSettings()[indexPath.row]
        let selectedUnit = userSettings.get(setting: setting.type)
        (cell as? SettingTableViewCell)?.setup(setting: setting, selectedUnit: selectedUnit)
        cell.selectionStyle = .none
        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}
