import XCTest
@testable import SpaceXApp

final class LaunchPresenterTests: XCTestCase {
    private var sut: LaunchPresenter!
    private var networkManagerMock: NetworkManagerMock!
    private var launchViewMock: LaunchViewMock!
    
    override func setUp() {
        super.setUp()
        networkManagerMock = NetworkManagerMock()
        sut = LaunchPresenter(rocketId: "nsdf8934ugfh", networkManager: networkManagerMock)
        launchViewMock = LaunchViewMock()
        sut.view = launchViewMock
    }
    
    override func tearDown() {
        sut = nil
        launchViewMock = nil
        networkManagerMock = nil
        super.tearDown()
    }
    
    func testGetLaunchesSuccessPath() {
        networkManagerMock.launches = [
            Launch(success: true,
                   rocket: "nsdf8934ugfh",
                   name: "Name1",
                   dateUtc: .init(timeIntervalSinceReferenceDate: 164764800.0)),
            Launch(success: false,
                   rocket: "nsdf8934ugfh",
                   name: "Name2",
                   dateUtc: .init(timeIntervalSinceReferenceDate: 196128000.0))
        ]

        sut.getLaunches()
        
        let actualLaunchesCells = launchViewMock.launchesCells
        let expectedLaunchesCells = [
            LaunchCell(name: "Name1", dateUtc: "23 марта 2006", image: "launchOk"),
            LaunchCell(name: "Name2", dateUtc: "21 марта 2007", image: "launchFail")
        ]
        XCTAssertEqual(actualLaunchesCells, expectedLaunchesCells)
    }
    
    func testGetLaunchesErrorPath() {
        networkManagerMock.launchesError = NSError(domain: "test", code: 0, userInfo: [NSLocalizedDescriptionKey: "Launches testing error"])

        sut.getLaunches()

        XCTAssertEqual(launchViewMock.launchesError, "Launches testing error")
    }

}

//MARK: - LaunchPresenter Mock

private extension LaunchPresenterTests {
    final class LaunchViewMock: LaunchViewProtocol {
        var launchesCells = [LaunchCell]()
        var launchesError: String?
        
        func present(launchesCells: [LaunchCell]) {
            self.launchesCells = launchesCells
        }
        
        func present(launchesError: String) {
            self.launchesError = launchesError
        }
    }
}
