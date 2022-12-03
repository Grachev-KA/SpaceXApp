import Foundation

struct Section {
    let type: SectionType
    let cells: [CellType]
    
    func makeCells(rocket: Rocket) -> [Section] {
        let imageBackgroungURL = URL(string: rocket.flickrImages[0])!
        let items = [
            Section(
                type: .imageAndTitle,
                cells: [
                    .header(image: imageBackgroungURL, title: rocket.name)
                ]
            ),
            Section(
                type: .orthogonal,
                cells: [
                    .info(title: "Высота, ft", value: String(rocket.height.feet ?? "")),
                    .info(title: "Диаметр, ft", value: String(rocket.diameter.feet ?? "")),
                    .info(title: "Масса, lb", value: String(rocket.mass.lb)),
                    .info(title: "Нагрузка, lb", value: String(rocket.mass.lb))
                ]
            ),
            Section(
                type: .vertical(title: ""),
                cells: [
                    .info(title: "Первый запуск", value: rocket.firstFlight),
                    .info(title: "Страна", value: rocket.country),
                    .info(title: "Стоимость запуска", value: String(rocket.costPerLaunch))
                ]
            ),
            Section(
                type: .vertical(title: "ПЕРВАЯ СТУПЕНЬ"),
                cells: [
                    .info(title: "Количество двигателей", value: String(rocket.firstStage.engines)),
                    .info(title: "Количество топлива", value: String(rocket.firstStage.fuelAmountTons)),
                    .info(title: "Время сгорания", value: String(rocket.firstStage.burnTimeSEC ?? ""))
                ]
            ),
            Section(
                type: .vertical(title: "ВТОРАЯ СТУПЕНЬ"),
                cells: [
                    .info(title: "Количество двигателей", value: String(rocket.secondStage.engines)),
                    .info(title: "Количество топлива", value: String(rocket.secondStage.fuelAmountTons)),
                    .info(title: "Время сгорания", value: String(rocket.secondStage.burnTimeSEC) ?? "")
                ]
            ),
            Section(
                type: .button,
                cells: [.button]
            )
        ]
        return items
    }
}

extension Section {
    enum CellType {
        case header(image: URL, title: String)
        case info(title: String, value: String)
        case button
    }
}

extension Section {
    enum SectionType {
        case imageAndTitle
        case orthogonal
        case vertical(title: String?)
        case button
    }
}
