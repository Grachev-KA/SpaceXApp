import UIKit

final class RocketsViewController: UIViewController {
    private let networkManager = NetworkManager()
    
    private let settingsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
        button.backgroundColor = .black
        button.setTitle("Настройки", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAllView()
        loadAllViewLayout()
        
        networkManager.getRockets(NetworkURL.spaceRockets) { result in
            switch result {
            case let .success(rockets):
                print("Результат \(rockets)")
            case let .failure(error):
                print(error)
            }
        }
        
        networkManager.getLaunches(NetworkURL.rocketLaunches) { result in
            switch result {
            case let .success(launches):
                print("Результат \(launches)")
            case let .failure(error):
                print(error)
            }
        }
    }
    
    @objc func openSettings() {
        let vc = SettingsViewController()
        present(vc, animated: true)
    }
    
    private func loadAllView() {
        view.addSubview(settingsButton)
    }
    
    private func loadAllViewLayout() {
        let constraints = [
            settingsButton.heightAnchor.constraint(equalToConstant: 30),
            settingsButton.widthAnchor.constraint(equalToConstant: 100),
            settingsButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            settingsButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}


