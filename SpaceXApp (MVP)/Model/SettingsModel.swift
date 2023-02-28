struct SettingsModel {
    let type: SettingsType
    let units: [Units]
    let selectedUnit: Units
}

extension SettingsModel {
    enum SettingsType: String {
        case height = "Высота"
        case diameter = "Диаметр"
        case weight = "Масса"
        case payload = "Полезная нагрузка"
    }

    enum Units: String {
        case meters = "m"
        case feet = "ft"
        case kilograms = "kg"
        case pounds = "lb"
    }

    static func availableSettings() -> [SettingsModel] {
        [
            SettingsModel(type: .height, units: [.meters, .feet], selectedUnit: .meters),
            SettingsModel(type: .diameter, units: [.meters, .feet], selectedUnit: .meters),
            SettingsModel(type: .weight, units: [.kilograms, .pounds], selectedUnit: .kilograms),
            SettingsModel(type: .payload, units: [.kilograms, .pounds], selectedUnit: .kilograms)
        ]
    }
}
