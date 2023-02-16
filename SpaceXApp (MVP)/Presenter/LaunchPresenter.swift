import Foundation

protocol LaunchPresenterModel: AnyObject {
   func getData()
}

protocol LaunchPresenterView: AnyObject {
    func present(data: [Launch])
}

class LaunchPresenter: LaunchPresenterModel, LaunchPresenterView {
    private let networkManager = NetworkManager()
    private var launches = [Launch]()
    
    func getData() {
        networkManager.getLaunches(NetworkUrl.launches) { result in
            switch result {
            case let .success(launches):
                self.launches = launches
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func present(data: self.launches) {
        print("test")
    }
}


