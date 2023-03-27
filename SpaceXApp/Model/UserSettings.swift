import Foundation

protocol UserSettingsProtocol {
    func save(setting: SettingsModel.SettingsType, value: SettingsModel.Units)
    func get(setting: SettingsModel.SettingsType) -> SettingsModel.Units?
}

final class UserSettings: UserSettingsProtocol {
    let userDefaults = UserDefaults.standard
    
    func save(setting: SettingsModel.SettingsType, value: SettingsModel.Units) {
        userDefaults.set(value.rawValue, forKey: setting.rawValue)
    }
    
    func get(setting: SettingsModel.SettingsType) -> SettingsModel.Units? {
        guard let getUnit = userDefaults.string(forKey: setting.rawValue) else { return nil }
        return SettingsModel.Units(rawValue: getUnit)
    }
}
