import XCTest
@testable import SpaceXApp

final class RocketPresenterTests: XCTestCase {
    private var sut: RocketPresenter!
    private var rocketViewMock: RocketViewMock!
    private let rocketStub = Rocket(
        height: .init(meters: 10.0, feet: 10.0),
        diameter: .init(meters: 10.0, feet: 10.0),
        mass: .init(kg: 10, lb: 10),
        payloadWeights: [.init(kg: 10, lb: 10)],
        firstStage: .init(engines: 10, fuelAmountTons: 10.0, burnTimeSec: 10),
        secondStage: .init(engines: 10, fuelAmountTons: 10.0, burnTimeSec: 10),
        flickrImages: ["www.flickrImages.com"],
        name: "name",
        firstFlight: .init(timeIntervalSinceReferenceDate: 164764800.0),
        country: "country",
        id: "id",
        costPerLaunch: 10
        )
    private let sectionsStub = [
        Section(
            type: .imageAndTitle,
            cells: [
                .header(image: URL(string: "www.flickrImages.com")!, title: "name")
            ]
        ),
        Section(
            type: .orthogonal,
            cells: [
                .info(title: "Высота, m", value: "10.0"),
                .info(title: "Диаметр, m", value: "10.0"),
                .info(title: "Масса, kg", value: "10"),
                .info(title: "Нагрузка, kg", value: "10")
            ]
        ),
        Section(
            type: .vertical(title: ""),
            cells: [
                .info(title: "Первый запуск", value: "23 марта 2006"),
                .info(title: "Страна", value: "country"),
                .info(title: "Стоимость запуска", value: "10")
            ]
        ),
        Section(
            type: .vertical(title: "ПЕРВАЯ СТУПЕНЬ"),
            cells: [
                .info(title: "Количество двигателей", value: "10"),
                .info(title: "Количество топлива", value: "10.0"),
                .info(title: "Время сгорания", value: "10")
            ]
        ),
        Section(
            type: .vertical(title: "ВТОРАЯ СТУПЕНЬ"),
            cells: [
                .info(title: "Количество двигателей", value: "10"),
                .info(title: "Количество топлива", value: "10.0"),
                .info(title: "Время сгорания", value: "10")
            ]
        ),
        Section(
            type: .button,
            cells: [.button]
        )
    ]
    
    override func setUp() {
        super.setUp()
        sut = RocketPresenter(rocket: rocketStub)
        rocketViewMock = RocketViewMock()
        sut.view = rocketViewMock
    }
    
    override func tearDown() {
        sut = nil
        rocketViewMock = nil
        super.tearDown()
    }
    
    func testGetSections() {
        sut.getSections()
        
        XCTAssertEqual(rocketViewMock.sections!, sectionsStub)
        XCTAssertEqual(rocketViewMock.rocketId!, "id")
    }
}

//MARK: - RocketPresenterTests Mock

private extension RocketPresenterTests {
    final class RocketViewMock: RocketViewProtocol {
        var sections: [Section]?
        var rocketId: String?
        
        func present(sections: [Section], rocketId: String) {
            self.sections = sections
            self.rocketId = rocketId
        }
    }
}
