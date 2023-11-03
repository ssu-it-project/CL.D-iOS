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
    
    var url: [String] = []
    private let prefetchItems = PublishSubject<Void>()
    private let didSelectReportAction = PublishSubject<ReportType>()
    
    private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .clear
        bindAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pauseAllVideoCells()
    }
    
    override func Bind() {
        let input = HomeViewModel.Input(viewWillAppearEvent: rx.viewWillAppear.map { _ in },
                                        prefetchItems: prefetchItems.asObserver(),
                                        didSelectReportAction: didSelectReportAction.asObserver())
        let output = viewModel.transform(input: input)
        
        output.homeRecordList
            .withUnretained(self)
            .subscribe { owner, _ in
                owner.collectionView.reloadData()
            }
            .disposed(by: disposeBag)
    }
    
    private func bindAction() {
        self.collectionView.rx.prefetchItems
            .compactMap(\.last?.row)
            .withUnretained(self)
            .bind { owner, row in
                guard row == owner.viewModel.recordListArray.count - 1 else { return }
                owner.prefetchItems.onNext(())
            }
            .disposed(by: self.disposeBag)
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
    
    private func menuActionSheet() {
        let alert = UIAlertController(title: "신고 사유 선택", message: nil, preferredStyle: .actionSheet)
         for report in ReportType.allCases {
             let alertAction = UIAlertAction(title: report.title, style: .default) { [weak self] _ in
                 self?.didSelectReportAction.onNext(report)
             }
             alert.addAction(alertAction)
         }
         let cancel = UIAlertAction(title: "취소", style: .cancel)
         alert.addAction(cancel)
         present(alert, animated: true)
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
            return 1
        case .videoBanner:
            return viewModel.recordListArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = HomeSectionType.allCases[indexPath.section]
        
        switch section {
        case .badgeSection:
            let cell: BadgeCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            cell.delegate = self
            return cell
        case .videoBanner:
            let cell: VideoCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            let recordVO = viewModel.cellArrayInfo(index: indexPath.item)
            cell.configureVideo(with: recordVO.video.original)
            cell.configureCell(row: recordVO)
            
            cell.rx.menuButtonTapped
                .drive(with: self) { owner, _ in
                    owner.menuActionSheet()
                }
                .disposed(by: cell.disposeBag)
            
            cell.rx.playerViewTapped
                .drive(with: self) { owner, _ in
                    owner.navigationController?.pushViewController(PlayerViewController(url: recordVO.video.original), animated: true)
                }
                .disposed(by: cell.disposeBag)
            
            return cell
        }
    }
        
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let cells = collectionView.visibleCells
        let videoCells = cells.compactMap({ $0 as? VideoCollectionViewCell })
        
        let yOffset = scrollView.contentOffset.y
        let frameHeight = scrollView.frame.size.height
        
        for videoCell in videoCells {
            if let indexPath = collectionView.indexPath(for: videoCell) {
                let cellRect = collectionView.layoutAttributesForItem(at: indexPath)?.frame
                if let rect = cellRect, rect.origin.y < yOffset + frameHeight * 0.6 {
                    videoCell.playerView.play()
                } else {
                    videoCell.playerView.pause()
                }
            }
        }
    }
}

extension HomeViewController {
    private func pauseAllVideoCells() {
        let cells = collectionView.visibleCells
        let videoCells = cells.compactMap({ $0 as? VideoCollectionViewCell })
        
        for videoCell in videoCells {
            videoCell.playerView.pause()
        }
    }
}

extension HomeViewController: TapBadgeButtonDelegate {
    func badgeButtonTapped() {
        self.presentAlert(title: "업데이트", message: "업데이트 이후 뱃지 정보를 제공 예정입니다. 양해부탁드립니다!", okButtonTitle: "확인")
    }
}
