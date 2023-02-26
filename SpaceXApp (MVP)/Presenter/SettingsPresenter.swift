protocol SettingsViewProtocol: AnyObject {
    func present(availableSettings: [SettingsModel])
    func present(selectedUnit: SettingsModel.Units?)
}

protocol SettingsPresenterProtocol: AnyObject {
    func getSettings()
    func getUserSettings(setting: SettingsModel)
    func saveUserSettings(setting: SettingsModel?, selectedSegmentIndex: Int)
}

final class SettingsPresenter {
    weak var view: SettingsViewProtocol?
    private let userSettings = UserSettings()
    
    init(view: SettingsViewProtocol?) {
        self.view = view
    }
}

// MARK: - SettingsPresenterProtocol

extension SettingsPresenter: SettingsPresenterProtocol {
    func getSettings() {
        let availableSettings = SettingsModel.availableSettings()
        view?.present(availableSettings: availableSettings)
    }
    
    func getUserSettings(setting: SettingsModel) {
        let selectedUnit = userSettings.get(setting: setting.type)
        view?.present(selectedUnit: selectedUnit)
    }
    
    func saveUserSettings(setting: SettingsModel?, selectedSegmentIndex: Int) {
        guard let setting = setting else { return }
        selectedSegmentIndex == 0 ? userSettings.save(setting: setting.type, value: setting.units[0]) : userSettings.save(setting: setting.type, value: setting.units[1])
    }
}
