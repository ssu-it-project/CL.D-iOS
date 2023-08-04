//
//  SelectListView.swift
//  CLD
//
//  Created by 이조은 on 2023/08/03.
//

import UIKit

import SnapKit

final class SelectListView: UIView {
    var selectCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        layout.sectionInset = .zero
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.canCancelContentTouches = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(SelectListCell.self,
                                forCellWithReuseIdentifier: SelectListCell.identifier)
        return collectionView
    }()
    
    private let dotDivider: UIImageView = {
        let view = UIImageView()
        view.image = ImageLiteral.dotDivider
        view.backgroundColor = nil
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setConstraints()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        addSubviews(selectCollectionView, dotDivider)
    }
    
    private func setConstraints() {
        selectCollectionView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(21)
        }
        dotDivider.snp.makeConstraints {
            $0.top.equalTo(selectCollectionView.snp.bottom).offset(15)
            $0.leading.equalToSuperview().inset(17)
            $0.trailing.equalToSuperview().inset(22)
            $0.height.equalTo(1)
        }
    }
}
