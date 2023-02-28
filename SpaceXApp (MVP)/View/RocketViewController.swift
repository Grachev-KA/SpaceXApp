import UIKit
import Kingfisher

final class RocketViewController: UIViewController {
    private let rocket: Rocket
    private lazy var collectionView = createCollectionView()
    private lazy var dataSource = createDataSource()
    
    init(rocket: Rocket) {
        self.rocket = rocket
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = dataSource
        
        dataSource.supplementaryViewProvider = { [unowned self] collectionView, kind, indexPath in
            self.createSupplementary(collectionView: collectionView, kind: kind, indexPath: indexPath)
        }
        
        createSections()
        loadAllViews()
    }
    
    private func loadAllViews() {
        view.addSubview(collectionView)
    }
}

//MARK: - UICollectionViewCompositionalLayout

extension RocketViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let imageAndTitleItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        let imageAndTitleItem = NSCollectionLayoutItem(layoutSize: imageAndTitleItemSize)
        let imageAndTitleGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(1))
        let imageAndTitleGroup = NSCollectionLayoutGroup.horizontal(layoutSize: imageAndTitleGroupSize, subitems: [imageAndTitleItem])
        let imageAndTitleSection = NSCollectionLayoutSection(group: imageAndTitleGroup)
        imageAndTitleSection.contentInsets = NSDirectionalEdgeInsets(top: -95, leading: 0, bottom: 10, trailing: 0)
        
        let orthogonalItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        let orthogonalItem = NSCollectionLayoutItem(layoutSize: orthogonalItemSize)
        let orthogonalGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.3),
            heightDimension: .fractionalWidth(0.3))
        let orthogonalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: orthogonalGroupSize, subitems: [orthogonalItem])
        let orthogonalSection = NSCollectionLayoutSection(group: orthogonalGroup)
        orthogonalSection.orthogonalScrollingBehavior = .continuous
        orthogonalSection.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: -10, trailing: 0)
        
        let verticalItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        let headerSection = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.1)), elementKind: InfoHeaderRocketViewCell.reuseIdentifier, alignment: .top)
        let verticalItem = NSCollectionLayoutItem(layoutSize: verticalItemSize)
        let verticalGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(0.1))
        let verticalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: verticalGroupSize, subitems: [verticalItem])
        let verticalSection = NSCollectionLayoutSection(group: verticalGroup)
        verticalSection.boundarySupplementaryItems = [headerSection]
        verticalSection.contentInsets = NSDirectionalEdgeInsets(top: -20, leading: 0, bottom: 20, trailing: 0)
        
        
        let buttonItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        let buttonItem = NSCollectionLayoutItem(layoutSize: buttonItemSize)
        let buttonGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(0.2))
        let buttonGroup = NSCollectionLayoutGroup.horizontal(layoutSize: buttonGroupSize, subitems: [buttonItem])
        let buttonSection = NSCollectionLayoutSection(group: buttonGroup)
        buttonSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0)
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            switch self.dataSource.snapshot().sectionIdentifiers[sectionIndex] {
            case .imageAndTitle: return imageAndTitleSection
            case .orthogonal: return orthogonalSection
            case .vertical: return verticalSection
            case .button: return buttonSection
            }
        }
        return layout
    }
}

// MARK: - UICollectionViewDiffableDataSource

extension RocketViewController {
    private func createDataSource() -> UICollectionViewDiffableDataSource<Section.SectionType, Section.CellType> {
        UICollectionViewDiffableDataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, item in
            switch item {
            case let .header(image: image, title: title):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderRocketsCollectionViewCell.reuseIdentifier, for: indexPath)
                (cell as? HeaderRocketsCollectionViewCell)?.setupViews(imageURL: image, title: title)
                (cell as? HeaderRocketsCollectionViewCell)?.settingsButtonOnClick = { [weak self] in
                    let vc = SettingsViewController()
                    self?.present(vc, animated: true)
                }
                return cell
                
            case let .info(title: title, value: value):
                if self?.dataSource.snapshot().sectionIdentifiers[indexPath.section] == .orthogonal {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoOrthogonalRocketViewCell.reuseIdentifier, for: indexPath)
                    (cell as? InfoOrthogonalRocketsCollectionViewCell)?.setupViews(title: title, value: value)
                    return cell
                    
                } else {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoVerticalRocketViewCell.reuseIdentifier, for: indexPath)
                    (cell as? InfoVerticalRocketsCollectionViewCell)?.setupViews(title: title, value: value)
                    return cell
                }
                
            case .button:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonRocketViewCell.reuseIdentifier, for: indexPath)
                (cell as? ButtonRocketsCollectionViewCell)?.launchesButtonOnClick = { [weak self] in
                    let vc = LaunchesViewController()
                    self?.present(vc, animated: true)
                }
                return cell
            }
        }
    }
    
    func createSupplementary(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? {
        guard kind == InfoHeaderRocketViewCell.reuseIdentifier else { return nil }
        let headerSection = collectionView.dequeueReusableSupplementaryView(ofKind: InfoHeaderRocketViewCell.reuseIdentifier, withReuseIdentifier: InfoHeaderRocketViewCell.reuseIdentifier, for: indexPath)
        guard case let .vertical(title) = dataSource.snapshot().sectionIdentifiers[indexPath.section] else { return nil }
        guard let title = title else { return nil }
        (headerSection as? InfoHeaderRocketViewCell)?.setupViews(title: title)
        return headerSection
    }
}

//MARK: - Sections + Snapshot

extension RocketViewController {
    private func createSections() {
        let sections = Section.makeCells(rocket: rocket)
        var snapshot = NSDiffableDataSourceSnapshot<Section.SectionType, Section.CellType>()
        for section in sections {
            snapshot.appendSections([section.type])
            snapshot.appendItems(section.cells, toSection: section.type)
        }
        dataSource.apply(snapshot)
    }
}

//MARK: - UICollectionView

extension RocketViewController {
    private func createCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .black
        collectionView.register(HeaderRocketsCollectionViewCell.self, forCellWithReuseIdentifier: HeaderRocketsCollectionViewCell.reuseIdentifier)
        collectionView.register(InfoOrthogonalRocketViewCell.self, forCellWithReuseIdentifier: InfoOrthogonalRocketViewCell.reuseIdentifier)
        collectionView.register(InfoVerticalRocketViewCell.self, forCellWithReuseIdentifier: InfoVerticalRocketViewCell.reuseIdentifier)
        collectionView.register(ButtonRocketViewCell.self, forCellWithReuseIdentifier: ButtonRocketViewCell.reuseIdentifier)
        collectionView.register(InfoHeaderRocketViewCell.self, forSupplementaryViewOfKind: InfoHeaderRocketViewCell.reuseIdentifier, withReuseIdentifier: InfoHeaderRocketViewCell.reuseIdentifier)
        return collectionView
    }
}
