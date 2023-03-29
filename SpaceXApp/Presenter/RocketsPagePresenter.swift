import Foundation

protocol RocketsPageViewProtocol: AnyObject {
    func present(rockets: [Rocket])
    func present(rocketsError: String)
}

protocol RocketsPagePresenterProtocol: AnyObject {
    func getRockets()
}

final class RocketsPagePresenter {
    weak var view: RocketsPageViewProtocol?
    private let networkManager: NetworkManagerRocketsProtocol
    
    init(view: RocketsPageViewProtocol, networkManager: NetworkManagerRocketsProtocol = NetworkManager()) {
        self.view = view
        self.networkManager = networkManager
    }
}

//MARK: - RocketsPagePresenterProtocol

extension RocketsPagePresenter: RocketsPagePresenterProtocol {
    func getRockets() {
        networkManager.getRockets { result in
            switch result {
            case let .success(rockets):
                self.view?.present(rockets: rockets)
                
            case let .failure(rocketsError):
                self.view?.present(rocketsError: rocketsError.localizedDescription)
            }
        }
    }
}
