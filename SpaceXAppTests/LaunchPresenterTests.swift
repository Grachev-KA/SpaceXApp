import XCTest
@testable import SpaceXApp

//MARK: - LaunchPresenterTests

final class LaunchPresenterTests: XCTestCase {
    private var sut: LaunchPresenter!
    private var networkManagerMock: NetworkManagerMock!
    private var launchViewMock: LaunchViewMock!
    
    override func setUp() {
        super.setUp()
        sut = LaunchPresenter(rocketId: "nsdf8934ugfh", networkManager: networkManagerMock)
        launchViewMock = LaunchViewMock()
        sut.view = launchViewMock
        networkManagerMock = NetworkManagerMock()
    }
    
    override func tearDown() {
        sut = nil
        launchViewMock = nil
        networkManagerMock = nil
        super.tearDown()
    }
    
    private func testGetLaunchesSuccessPath() {
        let calendar = Calendar.current
        let dateComponentsFirst = DateComponents(year: 2006, month: 3, day: 23, hour: 22, minute: 30, second: 0)
        let dateFirst = calendar.date(from: dateComponentsFirst)
        let dateComponentsSecond = DateComponents(year: 2007, month: 3, day: 21, hour: 1, minute: 10, second: 0)
        let dateSecond = calendar.date(from: dateComponentsSecond)
        networkManagerMock.launches = [
            Launch(success: true, rocket: "nsdf8934ugfh", name: "Name1", dateUtc: dateFirst!),
            Launch(success: false, rocket: "nsdf8934ugfh", name: "Name2", dateUtc: dateSecond!)
        ]
        
        sut.getLaunches()
        
        let actualLaunchesCells = launchViewMock.launchesCells
        let expectedLaunchesCells = [
            LaunchCell(name: "Name1", dateUtc: "23 марта 2006", image: "launchOk"),
            LaunchCell(name: "Name2", dateUtc: "21 марта 2007", image: "launchFail")
        ]
        XCTAssertEqual(actualLaunchesCells!, expectedLaunchesCells)
    }
}

private extension LaunchPresenterTests {
    final class NetworkManagerMock: NetworkManagerProtocol {
        var launches: [Launch]?
        
        func getLaunches(completionHandler: @escaping (Result<[Launch], Error>) -> Void) {
            completionHandler(.success(launches!))
        }
    }

    final class LaunchViewMock: LaunchViewProtocol {
        var launchesCells: [LaunchCell]?
        var error = ""
        
        func present(launchesCells: [LaunchCell], error: String) {
            self.launchesCells = launchesCells
            self.error = error
        }
    }
}
