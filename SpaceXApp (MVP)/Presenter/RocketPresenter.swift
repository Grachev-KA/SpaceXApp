protocol RocketViewProtocol: AnyObject {
    func present(sections: [Section], rocketId: String)
}

protocol RocketPresenterProtocol: AnyObject {
    func getSections()
}

final class RocketPresenter {
    weak var view: RocketViewProtocol?
    private var rocket: Rocket
    
    init(view: RocketViewProtocol?, rocket: Rocket) {
        self.view = view
        self.rocket = rocket
    }
}

//MARK: - RocketPresenterProtocol

extension RocketPresenter: RocketPresenterProtocol {
    func getSections() {
        let sections = Section.makeCells(rocket: rocket)
        view?.present(sections: sections, rocketId: rocket.id)
    }
}
