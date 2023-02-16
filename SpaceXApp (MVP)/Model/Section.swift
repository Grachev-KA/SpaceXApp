import Foundation

struct Section {
    let type: SectionType
    let cells: [CellType]
}

extension Section {
    enum SectionType: Hashable {
        case imageAndTitle
        case orthogonal
        case vertical(title: String?)
        case button
    }
}

extension Section {
    enum CellType: Hashable {
        case header(image: URL, title: String)
        case info(title: String, value: String)
        case button
    }
}

extension Section {
    static func makeCells(rocket: Rocket) -> [Section] {
        var sections = [Section]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let firstFlightString = dateFormatter.string(from: rocket.firstFlight)
        
        if let imageBackgroundURL = URL(string: rocket.flickrImages[0]) {
            sections.append(
                Section(
                    type: .imageAndTitle,
                    cells: [
                        .header(image: imageBackgroundURL, title: rocket.name)
                    ]
                )
            )
        }
        
        let sectionsWithoutImageAndTitle = [
            Section(
                type: .orthogonal,
                cells: [
                    .info(title: "Высота, ft", value: String(rocket.height.feet ?? 0)),
                    .info(title: "Диаметр, ft", value: String(rocket.diameter.feet ?? 0)),
                    .info(title: "Масса, lb", value: String(rocket.mass.lb)),
                    .info(title: "Нагрузка, lb", value: String(rocket.mass.lb))
                ]
            ),
            Section(
                type: .vertical(title: ""),
                cells: [
                    .info(title: "Первый запуск", value: firstFlightString),
                    .info(title: "Страна", value: rocket.country),
                    .info(title: "Стоимость запуска", value: String(rocket.costPerLaunch))
                ]
            ),
            Section(
                type: .vertical(title: "ПЕРВАЯ СТУПЕНЬ"),
                cells: [
                    .info(title: "Количество двигателей", value: String(rocket.firstStage.engines)),
                    .info(title: "Количество топлива", value: String(rocket.firstStage.fuelAmountTons)),
                    .info(title: "Время сгорания", value: String(rocket.firstStage.burnTimeSec ?? 0))
                ]
            ),
            Section(
                type: .vertical(title: "ВТОРАЯ СТУПЕНЬ"),
                cells: [
                    .info(title: "Количество двигателей", value: String(rocket.secondStage.engines)),
                    .info(title: "Количество топлива", value: String(rocket.secondStage.fuelAmountTons)),
                    .info(title: "Время сгорания", value: String(rocket.secondStage.burnTimeSec ?? 0))
                ]
            ),
            Section(
                type: .button,
                cells: [.button]
            )
        ]
        sections.append(contentsOf: sectionsWithoutImageAndTitle)
        return sections
    }
}
