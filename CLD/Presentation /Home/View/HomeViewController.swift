//
//  HomeViewController.swift
//  CLD
//
//  Created by 김규철 on 2023/07/18.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

final class HomeViewController: BaseViewController {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.alwaysBounceHorizontal = false
        collectionView.alwaysBounceVertical = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cell: BadgeCollectionViewCell.self)
        collectionView.register(cell: VideoCollectionViewCell.self)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical
        config.contentInsetsReference = .none
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in
            guard let section = HomeSectionType(rawValue: sectionIndex) else { return nil }
            switch section {
            case .badgeSection:
                return self?.getLayoutBadgeSection()
            case .videoBanner:
                return self?.getLayoutVideoSection()
            }
        }, configuration: config)
        
        return layout
    }
    
    private func getLayoutBadgeSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    private func getLayoutVideoSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.7))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }

    override func setHierarchy() {
        view.addSubview(collectionView)
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return HomeSectionType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = HomeSectionType.allCases[section]
        switch section {
        case .badgeSection:
            return 2
        case .videoBanner:
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = HomeSectionType.allCases[indexPath.section]
        
        switch section {
        case .badgeSection:
               let cell: BadgeCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
               return cell
        case .videoBanner:
            let cell: VideoCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }
    }
}
