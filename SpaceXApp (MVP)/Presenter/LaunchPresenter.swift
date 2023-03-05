import Foundation

protocol LaunchViewProtocol: AnyObject {
    func present(launchesCells: [LaunchCell])
}

protocol LaunchPresenterProtocol: AnyObject {
    func getLaunches()
}

final class LaunchPresenter {
    weak var view: LaunchViewProtocol?
    private let networkManager = NetworkManager()
    private let dateFormatter = DateFormatter()
    private let rocketId: String
    
    init(rocketId: String) {
        self.rocketId = rocketId
        dateFormatter.dateFormat = "dd MMMM yyyy"
    }
}

//MARK: - LaunchPresenterProtocol

extension LaunchPresenter: LaunchPresenterProtocol {
    func getLaunches() {
        networkManager.getLaunches(NetworkUrl.launches) { result in
            switch result {
            case let .success(launches):
                let launchesCells = launches.filter { $0.rocket == self.rocketId }
                    .map { launch in
                        let name = launch.name
                        let dateUtc = self.dateFormatter.string(from: launch.dateUtc)
                        let image = launch.success == true ? "launchOk" : "launchFail"
                        return LaunchCell(name: name, dateUtc: dateUtc, image: image)
                    }
                self.view?.present(launchesCells: launchesCells)
                
            case let .failure(error):
                print(error)
            }
        }
    }
}
