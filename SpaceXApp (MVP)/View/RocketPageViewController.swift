import UIKit

final class RocketPageViewController: UIPageViewController {
    private let networkManager = NetworkManager()
    private var rocket = [Rocket]()
    private lazy var rocketViewController = [RocketViewController]()
    
    private func createRocketViewController() {
        for i in rocket {
            let vc = RocketViewController(rocket: i)
            rocketViewController.append(vc)
        }
            setViewControllers([rocketViewController[0]], direction: .forward, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.getRockets(NetworkUrl.rockets) { result in
            switch result {
            case let .success(rockets):
                self.rocket = rockets
                DispatchQueue.main.sync {
                    self.createRocketViewController()
                }
            case let .failure(error):
                print(error)
            }
        }
        dataSource = self
    }
}

// MARK: - UIPageViewControllerDataSource

extension RocketPageViewController: UIPageViewControllerDataSource {
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
