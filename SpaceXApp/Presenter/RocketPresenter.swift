import Foundation

protocol RocketViewProtocol: AnyObject {
    func present(sections: [Section], rocketId: String)
}

protocol RocketPresenterProtocol: AnyObject {
    func getSections()
}

final class RocketPresenter {
    weak var view: RocketViewProtocol?
    private var rocket: Rocket
    private let dateFormatter = DateFormatter()
    private let userSettings = UserSettings()
    
    init(rocket: Rocket) {
        self.rocket = rocket
        dateFormatter.dateFormat = "dd MMMM yyyy"
    }
    
    private func makeCells(rocket: Rocket) -> [Section] {
        let heightTitle: String
        let heightValue: Double
        let diameterTitle: String
        let diameterValue: Double
        let massTitle: String
        let massValue: Int
        let payloadTitle: String
        let payloadValue: Int
        
        if userSettings.get(setting: .height) == .meters {
            heightTitle = "m"
            heightValue = rocket.height.meters
        } else {
            heightTitle = "ft"
            heightValue = rocket.height.feet
        }
        
        if userSettings.get(setting: .diameter) == .meters {
            diameterTitle = "m"
            diameterValue = rocket.diameter.meters
        } else {
            diameterTitle = "ft"
            diameterValue = rocket.diameter.feet
        }
        
        if userSettings.get(setting: .weight) == .kilograms {
            massTitle = "kg"
            massValue = rocket.mass.kg
        } else {
            massTitle = "lb"
            massValue = rocket.mass.lb
        }
        
        if userSettings.get(setting: .payload) == .kilograms {
            payloadTitle = "kg"
            payloadValue = rocket.payloadWeights[0].kg
        } else {
            payloadTitle = "lb"
            payloadValue = rocket.payloadWeights[0].lb
        }
        
        var sections = [Section]()
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
                    .info(title: "Высота, \(heightTitle)", value: String(heightValue)),
                    .info(title: "Диаметр, \(diameterTitle)", value: String(diameterValue)),
                    .info(title: "Масса, \(massTitle)", value: String(massValue)),
                    .info(title: "Нагрузка, \(payloadTitle)", value: String(payloadValue))
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

//MARK: - RocketPresenterProtocol

extension RocketPresenter: RocketPresenterProtocol {
    func getSections() {
        let makeSections = makeCells(rocket: rocket)
        view?.present(sections: makeSections, rocketId: rocket.id)
    }
}
