import Foundation

final class UserSettings {
    let userDefaults = UserDefaults.standard
    
    func save(setting: SettingsModel.SettingsType, value: SettingsModel.Units) {
        userDefaults.set(value.rawValue, forKey: setting.rawValue)
    }
    
    func get(setting: SettingsModel.SettingsType) -> SettingsModel.Units? {
        guard let getUnit = userDefaults.string(forKey: setting.rawValue) else { return nil }
        return SettingsModel.Units(rawValue: getUnit)
    }
}
