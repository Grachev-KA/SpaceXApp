import Foundation

protocol View: AnyObject {
    func present(launches: [Launch])
}

protocol Presenter: AnyObject {
    func getData()
}

final class LaunchPresenter {
    weak var view: View?
    private let networkManager = NetworkManager()
    
    init(view: View) {
      self.view = view
    }
    
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
