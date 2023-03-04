import Foundation

protocol RocketsPageViewProtocol: AnyObject {
    func present(rockets: [Rocket])
}

protocol RocketsPagePresenterProtocol: AnyObject {
    func getRockets()
}

final class RocketsPagePresenter {
    weak var view: RocketsPageViewProtocol?
    private let networkManager = NetworkManager()
    
    init(view: RocketsPageViewProtocol?) {
        self.view = view
    }
}

//MARK: - RocketsPagePresenterProtocol

extension RocketsPagePresenter: RocketsPagePresenterProtocol {
    func getRockets() {
        networkManager.getRockets(NetworkUrl.rockets) { result in
            switch result {
            case let .success(rockets):
                self.view?.present(rockets: rockets)
                
            case let .failure(error):
                print(error)
            }
        }
    }
}
