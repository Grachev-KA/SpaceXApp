import UIKit

final class RocketsPageViewController: UIPageViewController {
    private lazy var arrayRocketViewController = [firstRocketViewController, secondRocketViewController, thirdRocketViewController, fourthRocketViewController]
    
    private let firstRocketViewController: RocketsViewController = {
        let vc = RocketsViewController()
        vc.view.backgroundColor = .blue
        return vc
    }()
    
    private let secondRocketViewController: RocketsViewController = {
        let vc = RocketsViewController()
        vc.view.backgroundColor = .yellow
        return vc
    }()
    
    private let thirdRocketViewController: RocketsViewController = {
        let vc = RocketsViewController()
        vc.view.backgroundColor = .red
        return vc
    }()
    
    private let fourthRocketViewController: RocketsViewController = {
        let vc = RocketsViewController()
        vc.view.backgroundColor = .green
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        setViewControllers([arrayRocketViewController[0]], direction: .forward, animated: true)
    }
}

extension RocketsPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? RocketsViewController else { return nil }
        
        if let index = arrayRocketViewController.firstIndex(of: viewController), index > 0 {
            return arrayRocketViewController[index - 1]
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? RocketsViewController else { return nil }
        if let index = arrayRocketViewController.firstIndex(of: viewController), index < arrayRocketViewController.count - 1 {
            return arrayRocketViewController[index + 1]
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        arrayRocketViewController.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        0
    }
}

