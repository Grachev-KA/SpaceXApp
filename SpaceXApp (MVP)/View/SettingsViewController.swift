import UIKit

final class SettingsViewController: UIViewController {
    lazy private var presenter = SettingsPresenter(view: self)
    private var settings = [SettingsModel]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.reuseIdentifier)
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
        settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.reuseIdentifier, for: indexPath)
        let setting = settings[indexPath.row]
        let selectedUnit = setting.selectedUnit
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

extension SettingsViewController: SettingsViewProtocol {
    func present(settings: [SettingsModel]) {
        self.settings = settings
        tableView.reloadData()
    }
}
