import XCTest
@testable import SpaceXApp

final class RocketPresenterTests: XCTestCase {
    private var sut: RocketPresenter!
    private var rocketViewMock: RocketViewMock!
    private var sectionMock: SectionMock!
    private var rocketStub: Rocket!
    
    override func setUp() {
        super.setUp()
        rocketStub = Rocket(
            height: .init(feet: 10.0),
            diameter: .init(feet: 10.0),
            mass: .init(lb: 10),
            firstStage: .init(engines: 10, fuelAmountTons: 10.0, burnTimeSec: 10),
            secondStage: .init(engines: 10, fuelAmountTons: 10.0, burnTimeSec: 10),
            flickrImages: ["www.flickrImages.com"],
            name: "name",
            firstFlight: .init(timeIntervalSinceReferenceDate: 164764800.0),
            country: "country",
            id: "id",
            costPerLaunch: 10
            )
        sut = RocketPresenter(rocket: rocketStub)
        rocketViewMock = RocketViewMock()
        sectionMock = SectionMock()
    }
    
    override func tearDown() {
        sut = nil
        rocketViewMock = nil
        sectionMock = nil
        rocketStub = nil
        super.tearDown()
    }
    
    func testMakeCells() {
        let actualSections = sut.makeCells(rocket: rocketStub)
        let expectedSections = [
            Section(
                type: .imageAndTitle,
                cells: [
                    .header(image: URL(string: "www.flickrImages.com")!, title: "name")
                ]
            ),
            Section(
                type: .orthogonal,
                cells: [
                    .info(title: "Высота, ft", value: "10.0"),
                    .info(title: "Диаметр, ft", value: "10.0"),
                    .info(title: "Масса, lb", value: "10"),
                    .info(title: "Нагрузка, lb", value: "10")
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
        
        XCTAssertEqual(actualSections, expectedSections)
    }
    
    func testGetSections() {
        rocketViewMock.rocketId = "id"
        rocketViewMock.viewSections = [
            Section(
                type: .imageAndTitle,
                cells: [
                    .header(image: URL(string: "www.flickrImages.com")!, title: "name")
                ]
            ),
            Section(
                type: .orthogonal,
                cells: [
                    .info(title: "Высота, ft", value: "10.0"),
                    .info(title: "Диаметр, ft", value: "10.0"),
                    .info(title: "Масса, lb", value: "10"),
                    .info(title: "Нагрузка, lb", value: "10")
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
        
        sut.getSections()
        
        let expectedSections = [
            Section(
                type: .imageAndTitle,
                cells: [
                    .header(image: URL(string: "www.flickrImages.com")!, title: "name")
                ]
            ),
            Section(
                type: .orthogonal,
                cells: [
                    .info(title: "Высота, ft", value: "10.0"),
                    .info(title: "Диаметр, ft", value: "10.0"),
                    .info(title: "Масса, lb", value: "10"),
                    .info(title: "Нагрузка, lb", value: "10")
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
        XCTAssertEqual(rocketViewMock.viewSections, expectedSections)
        XCTAssertEqual(rocketViewMock.rocketId, "id")
    }
}

//MARK: - RocketPresenterTests Mocks

private extension RocketPresenterTests {
    final class RocketViewMock: RocketViewProtocol {
        var viewSections: [Section]?
        var rocketId: String?
        
        func present(sections: [Section], rocketId: String) {
            self.viewSections = sections
            self.rocketId = rocketId
        }
    }
    
    final class SectionMock { //нужен ли тут какой-нибудь протокол типа SectionProtocol?
        var rocket: Rocket?
        var modelSections: [Section]?
        
        func makeCells(rocket: Rocket) -> [Section] {
            self.rocket = rocket
            return modelSections!
        }
    }
}
