import UIKit

final class LaunchesViewController: UIViewController {
    private let networkManager = NetworkManager()
    private var rocketLaunches: [RocketLaunches] = []
    private let launchesView: LaunchesView = {
        let view = LaunchesView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.getLaunches(NetworkURL.rocketLaunches) { result in
            switch result {
            case let .success(launches):
                self.rocketLaunches = launches
                DispatchQueue.main.async {
                    self.launchesView.tableView.reloadData()
                }
            case let .failure(error):
                print(error)
            }
        }
        
        view = launchesView
        view.backgroundColor = .darkGray
        launchesView.tableView.dataSource = self
        launchesView.tableView.delegate = self
    }
}

extension LaunchesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rocketLaunches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LaunchTableViewCell.identifier, for: indexPath)
        let launch = rocketLaunches[indexPath.row]
        let imageLaunchStatus = UIImage(named: launch.success == true ? "launchOk" : "launchFail")
            
        (cell as? LaunchTableViewCell)?.setup(name: launch.name, dateUTC: launch.dateUTC, imageLaunchStatus: imageLaunchStatus)
        cell.selectionStyle = .none
        return cell
    }
}

extension LaunchesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}
