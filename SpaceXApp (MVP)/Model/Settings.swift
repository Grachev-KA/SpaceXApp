struct Settings {
    let type: SettingsType
    let units: [Units]
    let selectedUnit: Units
}

extension Settings {
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

    static func availableSettings() -> [Settings] {
        [
            Settings(type: .height, units: [.meters, .feet], selectedUnit: .meters),
            Settings(type: .diameter, units: [.meters, .feet], selectedUnit: .meters),
            Settings(type: .weight, units: [.kilograms, .pounds], selectedUnit: .kilograms),
            Settings(type: .payload, units: [.kilograms, .pounds], selectedUnit: .kilograms)
        ]
    }
}
