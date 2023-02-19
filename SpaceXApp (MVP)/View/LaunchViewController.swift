import UIKit
import Foundation

final class LaunchViewController: UIViewController {
    lazy private var presenter = LaunchPresenter(view: self)
    private var launches = [Launch]()
    private let dateFormatter = DateFormatter()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(LaunchCell.self, forCellReuseIdentifier: LaunchCell.reuseIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkGray
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        dateFormatter.dateFormat = "dd MMMM yyyy"
        presenter.getData()
        setLayout()
    }
    
    private func setLayout() {
        let constraints = [
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension LaunchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        launches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LaunchCell.reuseIdentifier, for: indexPath)
        let launch = launches[indexPath.row]
        let imageLaunchStatus = UIImage(named: launch.success == true ? "launchOk" : "launchFail")
        let dateUtcString = dateFormatter.string(from: launch.dateUtc)
        
        (cell as? LaunchCell)?.setup(name: launch.name, dateUtc: dateUtcString, imageLaunchStatus: imageLaunchStatus)
        cell.selectionStyle = .none
        return cell
    }
}

extension LaunchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}

extension LaunchViewController: LaunchViewProtocol {
    func present(launches: [Launch]) {
        self.launches = launches
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
