import UIKit

final class SettingsViewController: UIViewController {
    private lazy var presenter = SettingsPresenter(view: self)
    private var availableSettings = [SettingsModel]()
    private var selectedUnits = [SettingsModel.Units?]()
    private var updateSections: () -> Void
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.reuseIdentifier)
        tableView.backgroundColor = .black
        return tableView
    }()
    
    init(updateSections: @escaping () -> Void) {
        self.updateSections = updateSections
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = tableView
        view.backgroundColor = .black
        tableView.dataSource = self
        tableView.delegate = self
        presenter.getSettingsModelAndUserSettings()
        setLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        updateSections()
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

//MARK: - UITableViewDataSource

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        availableSettings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.reuseIdentifier, for: indexPath)
        let setting = availableSettings[indexPath.row]
        let selectedUnit = selectedUnits[indexPath.row]

        (cell as? SettingsTableViewCell)?.setupCell(setting: setting, selectedUnit: selectedUnit)
        cell.selectionStyle = .none
        
        (cell as? SettingsTableViewCell)?.onSettingChanged = { [weak self] selectedSegmentIndex in
            guard let self else { return }
            self.presenter.saveUserSettings(setting: setting, unit: setting.units[selectedSegmentIndex])
        }
        return cell
    }
}

//MARK: - UITableViewDelegate

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}

// MARK: - SettingsViewProtocol

extension SettingsViewController: SettingsViewProtocol {
    func present(availableSettings: [SettingsModel], selectedUnits: [SettingsModel.Units?]) {
        self.availableSettings = availableSettings
        self.selectedUnits = selectedUnits
        tableView.reloadData()
    }
}
