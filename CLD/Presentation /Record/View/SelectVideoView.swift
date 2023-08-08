//
//  SelectVideoView.swift
//  CLD
//
//  Created by 이조은 on 2023/08/04.
//

import UIKit

import SnapKit

final class SelectVideoView: UIView {    
    var selectCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.canCancelContentTouches = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(SelectVideoCell.self,
                                forCellWithReuseIdentifier: SelectVideoCell.identifier)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setConstraints()
        
        selectCollectionView.delegate = self
        selectCollectionView.dataSource = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHierarchy() {
        addSubview(selectCollectionView)
    }
    
    func setConstraints() {
        selectCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(347)
            $0.bottom.equalToSuperview()
        }
    }
}

extension SelectVideoView : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,
                            UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectVideoCell.identifier, for: indexPath) as? SelectVideoCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    // cell 항목 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 83, height: 81)
    }
    
    // 그리드의 항목 줄 사이에 사용할 최소 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    // 같은 행에 있는 항목 사이에 사용할 최소 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
