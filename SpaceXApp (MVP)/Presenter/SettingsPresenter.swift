protocol SettingsViewProtocol: AnyObject {
    func present(settings: [SettingsModel])
}

protocol SettingsPresenterProtocol: AnyObject {
    func getSettings()
}

final class SettingsPresenter {
    weak var view: SettingsViewProtocol?
    private let userSettings = UserSettings()
    
    init(view: SettingsViewProtocol?) {
        self.view = view
    }
}

extension SettingsPresenter: SettingsPresenterProtocol {
    func getSettings() {
        let availableSettings = SettingsModel.availableSettings()
        view?.present(settings: availableSettings)
    }
//    let selectedUnit = userSettings.get(setting: setting.type)
}
