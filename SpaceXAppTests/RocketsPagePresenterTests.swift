import XCTest
@testable import SpaceXApp

final class RocketsPagePresenterTests: XCTestCase {
    private var sut: RocketsPagePresenter!
    private var networkManagerMock: NetworkManagerMock!
    private var rocketsPageViewMock: RocketsPageViewMock!
    private let firstRocketStub = Rocket(height: .init(feet: 11.0),
                                         diameter: .init(feet: 12.0),
                                         mass: .init(lb: 13),
                                         firstStage: .init(engines: 14, fuelAmountTons: 15.0, burnTimeSec: nil),
                                         secondStage: .init(engines: 16, fuelAmountTons: 17.0, burnTimeSec: nil),
                                         flickrImages: ["www.firstRocket.com"],
                                         name: "Falcon 1",
                                         firstFlight: .init(timeIntervalSinceReferenceDate: 164764800.0),
                                         country: "Russia",
                                         id: "123",
                                         costPerLaunch: 18)
    private let secondRocketStub = Rocket(height: .init(feet: 111.0),
                                          diameter: .init(feet: 112.0),
                                          mass: .init(lb: 113),
                                          firstStage: .init(engines: 114, fuelAmountTons: 115.0, burnTimeSec: nil),
                                          secondStage: .init(engines: 116, fuelAmountTons: 117.0, burnTimeSec: nil),
                                          flickrImages: ["www.secondRocket.com"],
                                          name: "Falcon 2",
                                          firstFlight: .init(timeIntervalSinceReferenceDate: 196128000.0),
                                          country: "Russia",
                                          id: "1234",
                                          costPerLaunch: 19)
    
    override func setUp() {
        super.setUp()
        rocketsPageViewMock = RocketsPageViewMock()
        networkManagerMock = NetworkManagerMock()
        sut = RocketsPagePresenter(view: rocketsPageViewMock, networkManager: networkManagerMock)
    }
    
    override func tearDown() {
        sut = nil
        rocketsPageViewMock = nil
        networkManagerMock = nil
        super.tearDown()
    }
    
    func testGetRocketsSuccessPath() {
        networkManagerMock.rockets = [firstRocketStub, secondRocketStub]
        
        sut.getRockets()
        
        let actualRockets = rocketsPageViewMock.rockets
        let expectedRockets = [firstRocketStub, secondRocketStub]
        XCTAssertEqual(actualRockets, expectedRockets)
    }
    
    func testGetRocketsErrorPath() {
        networkManagerMock.rocketsError = NSError(domain: "test", code: 0, userInfo: [NSLocalizedDescriptionKey: "Rockets testing error"])
        
        sut.getRockets()

        XCTAssertEqual(rocketsPageViewMock.rocketsError, "Rockets testing error")
    }
}

//MARK: - RocketsPagePresenter Mock

private extension RocketsPagePresenterTests {
    final class RocketsPageViewMock: RocketsPageViewProtocol {
        var rockets = [Rocket]()
        var rocketsError: String?
        
        func present(rockets: [Rocket]) {
            self.rockets = rockets
        }
        
        func present(rocketsError: String) {
            self.rocketsError = rocketsError
        }
    }
}
