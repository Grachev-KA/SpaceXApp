import XCTest
@testable import SpaceXApp

final class RocketsPagePresenterTest: XCTestCase {
    private var sut: RocketsPagePresenter!
    private var networkManagerMock: NetworkManagerMock!
    private var rocketsPageViewMock: RocketsPageViewMock!
    
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
        networkManagerMock.rockets = [
            Rocket(height: .init(feet: 11.0),
                   diameter: .init(feet: 12.0),
                   mass: .init(lb: 13),
                   firstStage: .init(engines: 14, fuelAmountTons: 15.0, burnTimeSec: nil),
                   secondStage: .init(engines: 16, fuelAmountTons: 17.0, burnTimeSec: nil),
                   flickrImages: ["www.firstRocket.com"],
                   name: "Falcon 1",
                   firstFlight: .init(timeIntervalSinceReferenceDate: 164764800.0),
                   country: "Russia",
                   id: "123",
                   costPerLaunch: 18),
            Rocket(height: .init(feet: 111.0),
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
        ]
        
        sut.getRockets()
        
        let actualRockets = rocketsPageViewMock.rockets
        let expectedRockets = [
            Rocket(height: .init(feet: 11.0),
                   diameter: .init(feet: 12.0),
                   mass: .init(lb: 13),
                   firstStage: .init(engines: 14, fuelAmountTons: 15.0, burnTimeSec: nil),
                   secondStage: .init(engines: 16, fuelAmountTons: 17.0, burnTimeSec: nil),
                   flickrImages: ["www.firstRocket.com"],
                   name: "Falcon 1",
                   firstFlight: .init(timeIntervalSinceReferenceDate: 164764800.0),
                   country: "Russia",
                   id: "123",
                   costPerLaunch: 18),
            Rocket(height: .init(feet: 111.0),
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
        ]
        XCTAssertEqual(actualRockets, expectedRockets)
    }
    
    func testGetRocketsErrorPath() {
        networkManagerMock.rocketsError = NSError(domain: "test", code: 0, userInfo: [NSLocalizedDescriptionKey: "Rockets testing error"])
        
        sut.getRockets()
        
        let actualError = rocketsPageViewMock.rocketsError
        let expectedError = "Rockets testing error"
        XCTAssertEqual(actualError, expectedError)
    }
}

//MARK: - RocketsPagePresenter Mocks

private extension RocketsPagePresenterTest {
    final class NetworkManagerMock: NetworkManagerRocketsProtocol {
        var rockets: [Rocket]?
        var rocketsError: Error?
        
        func getRockets(completionHandler: @escaping (Result<[Rocket], Error>) -> Void) {
            if let rockets {
                completionHandler(.success(rockets))
            } else {
                completionHandler(.failure(rocketsError!))
            }
        }
    }
    
    final class RocketsPageViewMock: RocketsPageViewProtocol {
        var rockets = [Rocket]()
        var rocketsError = ""
        
        func present(rockets: [Rocket]) {
            self.rockets = rockets
        }
        
        func present(rocketsError: String) {
            self.rocketsError = rocketsError
        }
    }
}
