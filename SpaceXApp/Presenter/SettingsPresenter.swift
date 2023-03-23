protocol SettingsViewProtocol: AnyObject {
    func present(availableSettings: [SettingsModel], selectedUnits: [SettingsModel.Units?])
}

protocol SettingsPresenterProtocol: AnyObject {
    func getSettingsModelAndUserSettings()
    func saveUserSettings(setting: SettingsModel, unit: SettingsModel.Units)
}

final class SettingsPresenter {
    weak var view: SettingsViewProtocol?
    private let userSettings: UserSettingsProtocol
    
    init(view: SettingsViewProtocol, userSettings: UserSettingsProtocol = UserSettings()) {
        self.view = view
        self.userSettings = userSettings
    }
}

// MARK: - SettingsPresenterProtocol

extension SettingsPresenter: SettingsPresenterProtocol {
    func getSettingsModelAndUserSettings() {
        let availableSettings = SettingsModel.availableSettings()
        let selectedUnits = availableSettings.map { setting in
            userSettings.get(setting: setting.type)
        }
        view?.present(availableSettings: availableSettings, selectedUnits: selectedUnits)
    }
    
    func saveUserSettings(setting: SettingsModel, unit: SettingsModel.Units) {
        userSettings.save(setting: setting.type, value: unit)
    }
}
