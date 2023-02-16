import Foundation

final class UserSettings {
    let userDefaults = UserDefaults.standard
    
    func save(setting: Settings.SettingsType, value: Settings.Units) {
        userDefaults.set(value.rawValue, forKey: setting.rawValue)
    }
    
    func get(setting: Settings.SettingsType) -> Settings.Units? {
        guard let getUnit = userDefaults.string(forKey: setting.rawValue) else { return nil }
        return Settings.Units(rawValue: getUnit)
    }
}
