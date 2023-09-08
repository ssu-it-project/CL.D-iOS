//
//  SelectColorViewController.swift
//  CLD
//
//  Created by 이조은 on 2023/08/01.
//

import UIKit

import SnapKit

final class SelectColorViewController: BaseViewController {
    private var colorData = [ColorChipName.white,ColorChipName.gray,ColorChipName.black,ColorChipName.blue,ColorChipName.red,ColorChipName.brown,ColorChipName.pink,ColorChipName.green,ColorChipName.purple,ColorChipName.orange,ColorChipName.yellow]
    var colorInfo: ColorChipName? = nil
    var colorText: String = ""
    private var addColorName: String = ""
    
    private let dotDivider: UIImageView = {
        let view = UIImageView()
        view.image = ImageLiteral.dotDivider
        view.tintColor = .CLDDarkDarkGray
        view.backgroundColor = nil
        return view
    }()
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
    private let addButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 83, height: 81)
        button.layer.backgroundColor = UIColor.CLDLightGray.cgColor
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(addColor), for: .touchUpInside)
        return button
    }()
    private let addIcon: UIImageView = {
        let view = UIImageView()
        view.image = ImageLiteral.addIcon
        view.tintColor = .CLDDarkDarkGray
        view.backgroundColor = nil
        return view
    }()
    private let addLabel: UILabel = {
        let label = UILabel()
        label.text = "추가"
        label.textColor = .CLDBlack
        label.font = UIFont(name: "Roboto-Regular", size: 11)
        return label
    }()
    
    @objc private func addColor () {
        let alert = UIAlertController(title: "색상 추가", message: "추가할 색상을 입력해주세요.", preferredStyle: .alert)
        alert.addTextField(){ (text) in
            text.placeholder = "예시) 민트"
        }
        let okAction = UIAlertAction(title: "추가하기", style: .default) { _ in
            if let txt = alert.textFields?[0].text {
                self.addColorName = txt
                self.colorData.append(ColorChipName.addColor)
                self.addButton.isHidden = true
                self.selectCollectionView.reloadData()
            }
            return
        }
        let cancelAction = UIAlertAction(title: "취소하기", style: .destructive)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        selectCollectionView.delegate = self
        selectCollectionView.dataSource = self
        
        setHierarchy()
        setConstraints()
    }
    
    override func setHierarchy() {
        self.view.addSubviews(dotDivider,selectCollectionView)
        selectCollectionView.addSubview(addButton)
        addButton.addSubview(addIcon)
        addButton.addSubview(addLabel)
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
            $0.height.equalTo(253)
        }
        addButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(172)
            $0.leading.equalToSuperview().inset(264)
            $0.width.equalTo(83)
            $0.height.equalTo(81)
        }
        addIcon.snp.makeConstraints {
            $0.top.equalToSuperview().inset(22)
            $0.size.equalTo(21)
            $0.centerX.equalToSuperview()
        }
        addLabel.snp.makeConstraints {
            $0.top.equalTo(addIcon.snp.bottom).offset(18)
            $0.bottom.equalToSuperview().inset(6)
            $0.centerX.equalToSuperview()
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
        let color = colorData[indexPath.row]
        if (color == ColorChipName.addColor) {
            cell.colorLabel.text = addColorName
        }
        else { cell.colorLabel.text = color.colorName() }
        cell.colorCircle.layer.backgroundColor = color.colorChip()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 83, height: 81)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SelectColorCell {
            colorInfo = colorData[indexPath.row]
            self.colorText = cell.colorLabel.text ?? ""
        }
    }
}
