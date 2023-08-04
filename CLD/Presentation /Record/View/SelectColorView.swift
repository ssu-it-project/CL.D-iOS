//
//  SelectColorView.swift
//  CLD
//
//  Created by 이조은 on 2023/08/01.
//

import UIKit

import SnapKit

final class SelectColorView: UIView {
    let colorData = ["흰색","회색","검정","파랑","빨강","갈색","핑크","초록","보라","주황","노랑","추가"]
    
    var selectCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.canCancelContentTouches = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(SelectColorCell.self,
                                forCellWithReuseIdentifier: SelectColorCell.identifier)
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

extension SelectColorView : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,
                            UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectColorCell.identifier, for: indexPath) as? SelectColorCell else {
            return UICollectionViewCell()
        }
        let colorName = colorData[indexPath.row]
        cell.colorLabel.text = colorName
        
        switch colorName {
        case "흰색":
            cell.colorCircle.layer.backgroundColor = UIColor.ChipWhite.cgColor
        case "회색":
            cell.colorCircle.layer.backgroundColor = UIColor.ChipGray.cgColor
        case "검정":
            cell.colorCircle.layer.backgroundColor = UIColor.ChipBlack.cgColor
        case "파랑":
            cell.colorCircle.layer.backgroundColor = UIColor.ChipBlue.cgColor
        case "빨강":
            cell.colorCircle.layer.backgroundColor = UIColor.ChipRed.cgColor
        case "갈색":
            cell.colorCircle.layer.backgroundColor = UIColor.ChipBrown.cgColor
        case "핑크":
            cell.colorCircle.layer.backgroundColor = UIColor.ChipPink.cgColor
        case "초록":
            cell.colorCircle.layer.backgroundColor = UIColor.ChipGreen.cgColor
        case "보라":
            cell.colorCircle.layer.backgroundColor = UIColor.ChipPurple.cgColor
        case "주황":
            cell.colorCircle.layer.backgroundColor = UIColor.ChipOrange.cgColor
        case "노랑":
            cell.colorCircle.layer.backgroundColor = UIColor.ChipYellow.cgColor
        default :
            cell.colorCircle.layer.backgroundColor = UIColor.CLDLightGray.cgColor
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
