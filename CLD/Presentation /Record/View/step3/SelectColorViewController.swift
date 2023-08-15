//
//  SelectColorViewController.swift
//  CLD
//
//  Created by 이조은 on 2023/08/01.
//

import UIKit

import SnapKit

final class SelectColorViewController: BaseViewController {
    private let dotDivider: UIImageView = {
        let view = UIImageView()
        view.image = ImageLiteral.dotDivider
        view.tintColor = .CLDDarkDarkGray
        view.backgroundColor = nil
        return view
    }()
    
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
    let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.CLDBlack, for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 15)
        button.semanticContentAttribute = .forceLeftToRight
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(nextView), for: .touchUpInside)
        return button
    }()
    @objc private func nextView () {
        print("다음")
        // self.present(SelectSectorViewController(), animated: true)
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        selectCollectionView.delegate = self
        selectCollectionView.dataSource = self
        
        setHierarchy()
        setConstraints()
    }
    
    override func setHierarchy() {
        self.view.addSubviews(dotDivider,selectCollectionView,nextButton)
    }
    
    override func setConstraints() {
        dotDivider.snp.makeConstraints {
            $0.top.equalToSuperview().inset(77)
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview().inset(19)
        }
        selectCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(85)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(347)
            $0.bottom.equalToSuperview()
        }
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(72)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(28)
            $0.height.equalTo(18)
        }
    }
}

extension SelectColorViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,
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
