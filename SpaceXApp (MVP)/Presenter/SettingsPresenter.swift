protocol SettingsViewProtocol: AnyObject {
    func present(availableSettings: [SettingsModel])
    func present(selectedUnit: SettingsModel.Units?)
}

protocol SettingsPresenterProtocol: AnyObject {
    func getSettings()
    func getUserSettings(setting: SettingsModel)
    func saveUserSettings(selectedSegmentIndex: Int)
}

final class SettingsPresenter {
    weak var view: SettingsViewProtocol?
    private var setting: SettingsModel?
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
    
    func saveUserSettings(selectedSegmentIndex: Int) {
        guard let setting = setting else { return } //setting всегда nil
        selectedSegmentIndex == 0 ? userSettings.save(setting: setting.type, value: setting.units[0]) : userSettings.save(setting: setting.type, value: setting.units[1])
    }
}
