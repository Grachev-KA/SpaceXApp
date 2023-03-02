protocol RocketViewProtocol: AnyObject {
    func present(sections: [Section])
}

protocol RocketPresenterProtocol: AnyObject {
    func getSections(rocket: Rocket)
}

final class RocketPresenter {
    weak var view: RocketViewProtocol?
    
    init(view: RocketViewProtocol) {
        self.view = view
    }
}

//MARK: - RocketPresenterProtocol

extension RocketPresenter: RocketPresenterProtocol {
    func getSections(rocket: Rocket) {
        let sections = Section.makeCells(rocket: rocket)
        view?.present(sections: sections)
    }
}
