import Foundation

protocol LaunchViewProtocol: AnyObject {
    func present(launchesCells: [LaunchCell])
    func present(launchesError: String)
}

protocol LaunchPresenterProtocol: AnyObject {
    func getLaunches()
}

final class LaunchPresenter {
    weak var view: LaunchViewProtocol?
    private let networkManager: NetworkManagerProtocol
    private let dateFormatter = DateFormatter()
    private let rocketId: String
    
    init(rocketId: String, networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.rocketId = rocketId
        dateFormatter.dateFormat = "dd MMMM yyyy"
        self.networkManager = networkManager
    }
}

//MARK: - LaunchPresenterProtocol

extension LaunchPresenter: LaunchPresenterProtocol {
    func getLaunches() {
        networkManager.getLaunches { result in
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
                
            case let .failure(launchesError):
                self.view?.present(launchesError: launchesError.localizedDescription)
                
            }
        }
    }
}
