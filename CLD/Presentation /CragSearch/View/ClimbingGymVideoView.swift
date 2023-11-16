//
//  ClimbingGymVideoView.swift
//  CLD
//
//  Created by 김규철 on 2023/09/16.
//

import UIKit

final class ClimbingGymVideoView: BaseView {
    
    enum Section {
        case video
    }
    
    typealias ClimbingGymVideoCellRegistration = UICollectionView.CellRegistration<ClimbingGymVideoCollectionViewCell, RecordVO>
    typealias DiffableDataSource = UICollectionViewDiffableDataSource<Section, RecordVO>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, RecordVO>
    var dataSource: DiffableDataSource!
    
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "검색"
        view.searchBarStyle = .minimal
        view.showsCancelButton = true
        return view
    }()
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCellRegistrationAndDataSource()
    }
    
    func applyCollectionViewDataSource(
        by viewModels: [RecordVO]
    ) {
        var snapshot = Snapshot()
        
        snapshot.appendSections([.video])
        snapshot.appendItems(viewModels, toSection: .video)
        
        dataSource.apply(snapshot)
    }
    
    func itemIdentifier(for indexPath: IndexPath) -> RecordVO? {
        return dataSource.itemIdentifier(for: indexPath)
    }
    
    private func configureCellRegistrationAndDataSource() {
        let ClimbingGymVideoCellRegistration = ClimbingGymVideoCellRegistration { cell, _, record in
            cell.configureCell(row: record)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: ClimbingGymVideoCellRegistration, for: indexPath, item: itemIdentifier)
            return cell
            
        })
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { [weak self] _, _ -> NSCollectionLayoutSection? in
            return self?.createSection()
        })
        return layout
    }
    
    private func createSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(270))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section =  NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    override func setHierarchy() {
        self.addSubviews(searchBar, collectionView)
    }
    
    override func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(5)
            make.height.equalTo(50)
        }
        
        if let searchBarTextField = searchBar.value(forKey: "searchField") as? UITextField {
            searchBarTextField.frame = CGRect(x: searchBarTextField.frame.origin.x, y: searchBarTextField.frame.origin.y, width: searchBarTextField.frame.size.width, height: 50)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.equalTo(searchBar.snp.leading)
            make.trailing.equalTo(searchBar.snp.trailing)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(10)
        }
    }
}
