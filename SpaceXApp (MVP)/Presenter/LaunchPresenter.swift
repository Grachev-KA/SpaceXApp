import Foundation

protocol LaunchViewProtocol: AnyObject {
    func present(launches: [Launch])
}

protocol LaunchPresenterProtocol: AnyObject {
    func getData()
}

final class LaunchPresenter {
    weak var view: LaunchViewProtocol?
    private let networkManager = NetworkManager()
    
    init(view: LaunchViewProtocol) {
      self.view = view
    }
}

extension LaunchPresenter: LaunchPresenterProtocol {
    func getData() {
        networkManager.getLaunches(NetworkUrl.launches) { result in
            switch result {
            case let .success(launches):
                self.view?.present(launches: launches)
            case let .failure(error):
                print(error)
            }
        }
    }
}
