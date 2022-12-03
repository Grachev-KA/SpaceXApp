import UIKit

final class RocketsViewController: UIViewController {
    private let networkManager = NetworkManager()
    private var rockets: [Rocket] = []
    
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
        
        //    collection.layout = compLaout { section, _ -> NSCollectionLayoutSection in
        //        switch items[section].type {
        //        case .button:
        //            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalHeight(1))
        //            let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //
        //            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(fraction))
        //            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        //
        //            return NSCollectionLayoutSection(group: group)
        //        case vertical:
        //            // вовзвращаем секуйцию
        //            returnn NSCollectionLayoutSection(group: group)
        //        case horizontal:
        //            return NSCollectionLayoutSection(group: group)
        //        }
        //    }
        //
        //
        //    dataSource = { collectionView, indexPath, item -> UICollectionViewCell in
        //        switch item {
        //        case .button:
        //            let cell = collectionView.dequeue... as? ButtonCollectionViewCell
        //            return cell
        //        case let .info(title, value):
        //            let cell = collectionView.dequeue... as? InfoCollectionViewCell
        //            cell.setup(title, value)
        //            return cell
        //        case .image:
        //            ...
        //        }
        //    }
        
        
        networkManager.getRockets(NetworkURL.rockets) { result in
            switch result {
            case let .success(rockets):
                self.rockets = rockets
                DispatchQueue.main.async {
                    self.rocketsView.tableView.reloadData()
                }
            case let .failure(error):
                print(error)
            }
        }
//        networkManager.getRockets(NetworkURL.rockets) { result in
//            switch result {
//            case let .success(rockets):
//                print("Результат \(rockets)")
//            case let .failure(error):
//                print(error)
//            }
//        }
//
//        networkManager.getLaunches(NetworkURL.launches) { result in
//            switch result {
//            case let .success(launches):
//                print("Результат \(launches)")
//            case let .failure(error):
//                print(error)
//            }
//        }
        
        loadAllView()
        loadAllViewLayout()
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


