import UIKit
import Foundation

final class LaunchViewController: UIViewController {
    private let presenter: LaunchPresenter
    private var launchesCells = [LaunchCell]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(LaunchViewCell.self, forCellReuseIdentifier: LaunchViewCell.reuseIdentifier)
        return tableView
    }()
    
    init(presenter: LaunchPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        tableView.dataSource = self
        tableView.delegate = self
        presenter.getLaunches()
        setViews()
        setLayout()
    }
    
    private func getLaunchesErrorAlert(launchesError: String) {
        let alert = UIAlertController(title: "Network error", message: launchesError, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(defaultAction)
        
        present(alert, animated: true)
    }
    
    private func setViews() {
        view.addSubview(tableView)
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

//MARK: - UITableViewDataSource

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
    
    func present(launchesError: String) {
        getLaunchesErrorAlert(launchesError: launchesError)
    }
}
