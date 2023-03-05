import UIKit

final class RocketsPageViewController: UIPageViewController {
    private lazy var presenter = RocketsPagePresenter(view: self)
    private var rockets = [Rocket]()
    private lazy var rocketViewController = [RocketViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        presenter.getRockets()
    }
    
    private func createRocketViewController() {
        DispatchQueue.main.async {
            for rocket in self.rockets {
                let presenter = RocketPresenter(rocket: rocket)
                let vc = RocketViewController(presenter: presenter, rocketId: rocket.id)
                presenter.view = vc
                self.rocketViewController.append(vc)
            }
            self.setViewControllers([self.rocketViewController[0]], direction: .forward, animated: true)
        }
    }
}

// MARK: - UIPageViewControllerDataSource

extension RocketsPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? RocketViewController else { return nil }
        if let index = rocketViewController.firstIndex(of: viewController), index > 0 {
            return rocketViewController[index - 1]
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? RocketViewController else { return nil }
        if let index = rocketViewController.firstIndex(of: viewController), index < rocketViewController.count - 1 {
            return rocketViewController[index + 1]
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        rocketViewController.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        0
    }
}

//MARK: - RocketsPageViewProtocol

extension RocketsPageViewController: RocketsPageViewProtocol {
    func present(rockets: [Rocket]) {
        self.rockets = rockets
        createRocketViewController()
    }
}
