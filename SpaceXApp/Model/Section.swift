import Foundation

struct Section {
    let type: SectionType
    let cells: [CellType]
    
    func makeCells(rocket: Rocket) -> [Section] {
        var sections = [Section]()
        let imageBackgroungURL = URL(string: rocket.flickrImages[0])
        
        if let image = imageBackgroungURL {
            sections.append(Section(
                type: .imageAndTitle,
                cells: [
                    .header(image: image, title: rocket.name)
                ]
            )
            )
        }
        
        var sectionsWithoutImageAndTitle = [
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
