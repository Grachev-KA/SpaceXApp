import Foundation

protocol LaunchViewProtocol: AnyObject {
    func present(launches: [Launch])
}

protocol LaunchPresenterProtocol: AnyObject {
    func getLaunches()
}

final class LaunchPresenter {
    weak var view: LaunchViewProtocol? //ПОЧЕМУ weak, а не unowned? Время жизни LaunchVC больше, чем LaunchPresenter
    private let networkManager = NetworkManager()
    var rocketId: String
    
    init(view: LaunchViewProtocol, rocketId: String) {
        self.view = view
        self.rocketId = "5e9d0d95eda69955f709d1eb"
    }
}

extension LaunchPresenter: LaunchPresenterProtocol {
    func getLaunches() {
        networkManager.getLaunches(NetworkUrl.launches) { result in
            switch result {
            case let .success(launches):
                var launchesSort = [Launch]()
                for launch in launches {
                    if launch.rocket == self.rocketId {
                        launchesSort.append(launch)
                    }
                }
                self.view?.present(launches: launchesSort)
            case let .failure(error):
                print(error)
            }
        }
    }
}
