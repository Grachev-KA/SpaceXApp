import UIKit
import Foundation

final class LaunchViewController: UIViewController {
    private lazy var presenter = LaunchPresenter(view: self, rocketId: "5e9d0d95eda69955f709d1eb")
    private var launchesCells = [LaunchCell]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(LaunchViewCell.self, forCellReuseIdentifier: LaunchViewCell.reuseIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        presenter.getLaunches()
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
        launchesCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LaunchViewCell.reuseIdentifier, for: indexPath)
        let launchCell = launchesCells[indexPath.row]
        let imageLaunchStatus = UIImage(named: launchCell.image)
        
        (cell as? LaunchViewCell)?.setup(name: launchCell.name, dateUtc: launchCell.dateUtc, imageLaunchStatus: imageLaunchStatus)
        cell.selectionStyle = .none
        return cell
    }
}

extension LaunchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}

//MARK: - LaunchViewProtocol

extension LaunchViewController: LaunchViewProtocol {
    func present(launchesCells: [LaunchCell]) {
        self.launchesCells = launchesCells
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
