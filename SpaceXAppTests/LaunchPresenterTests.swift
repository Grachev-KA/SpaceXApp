import XCTest
@testable import SpaceXApp

final class LaunchPresenterTests: XCTestCase {
    var sut: NetworkManagerMock!
    var presenterMock: LaunchPresenter!
    var launchViewMock: LaunchViewMock!
    var dateFormatter: DateFormatter!
    
    override func setUp() {
        super.setUp()
        sut = NetworkManagerMock()
        presenterMock = LaunchPresenter(rocketId: "nsdf8934ugfh", networkManager: sut)
        launchViewMock = LaunchViewMock()
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        presenterMock.view = launchViewMock
    }
    
    override func tearDown() {
        sut = nil
        presenterMock = nil
        launchViewMock = nil
        dateFormatter = nil
        super.tearDown()
    }
    
    func testLaunches() {
        let dateFirst = dateFormatter.date(from: "2006-03-24T22:30:00.000Z")
        let dateSecond = dateFormatter.date(from: "2007-03-21T01:10:00.000Z")
        sut.launches = [
            Launch(success: true, rocket: "nsdf8934ugfh", name: "Name1", dateUtc: dateFirst!),
            Launch(success: false, rocket: "nsdf8934ugfh", name: "Name2", dateUtc: dateSecond!)
        ]
        
        presenterMock.getLaunches()
        
        let actualLaunchesCells = launchViewMock.launchesCells
        let expectedLaunchesCells = [
            LaunchCell(name: "Name1", dateUtc: "24 марта 2006", image: "launchOk"),
            LaunchCell(name: "Name2", dateUtc: "21 марта 2007", image: "launchFail")
        ]
        XCTAssertEqual(actualLaunchesCells!, expectedLaunchesCells)
    }
}

extension LaunchPresenterTests {
    final class NetworkManagerMock: NetworkManagerProtocol {
        var launches: [Launch]?
        
        func getLaunches(completionHandler: @escaping (Result<[Launch], Error>) -> Void) {
            completionHandler(.success(launches!))
        }
    }
}

extension LaunchPresenterTests {
    final class LaunchViewMock: LaunchViewProtocol {
        var launchesCells: [LaunchCell]?
        
        func present(launchesCells: [LaunchCell]) {
            self.launchesCells = launchesCells
        }
    }
}
