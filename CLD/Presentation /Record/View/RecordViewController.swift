//
//  RecordViewController.swift
//  CLD
//
//  Created by 김규철 on 2023/07/20.
//

import UIKit

import SnapKit

class RecordViewController: BaseViewController {
    private let selectList = ["클라이밍장","섹터","난이도 색상","영상"]
    
    private let selectListView = SelectListView()
    private let selectPlaceView = SelectPlaceView()
    private let selectSectorView = SelectSectorView()
    private let selectColorView = SelectColorView()
    
    private var selectListViewIndex = 0
    
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
        print(selectListViewIndex)
        collectionView(selectListView.selectCollectionView, didSelectItemAt: IndexPath(item: selectListViewIndex+1, section: 0))
        collectionView(selectListView.selectCollectionView, didSelectItemAt: IndexPath(item: selectListViewIndex+1, section: 0))
    }
    @objc private func keyboardWillShow(_ notification: Notification) {
        // 키보드가 생성될 때
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            if self.view.frame.origin.y == 0 {
                self.nextButton.frame.origin.y -= keyboardHeight
            }
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        // 키보드가 사라질 때
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            self.nextButton.frame.origin.y += keyboardHeight
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectListView.selectCollectionView.delegate = self
        selectListView.selectCollectionView.dataSource = self
        
        selectListView.selectCollectionView.selectItem(at: [0,0], animated: false, scrollPosition: .init())
        
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func setHierarchy() {
        self.view.addSubviews(selectListView,selectPlaceView,selectSectorView,nextButton)
    }
    
    override func setConstraints() {
        selectListView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(37)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }
        selectPlaceView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(94)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(55)
        }
        selectSectorView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(94)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(35)
        }
        //        selectColorView.snp.makeConstraints {
        //            $0.top.equalTo(selectListView.snp.bottom).offset(8)
        //            $0.leading.trailing.equalToSuperview()
        //            $0.bottom.equalToSuperview().inset(5)
        //        }
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(72)
            $0.height.equalTo(20)
            $0.centerX.equalToSuperview()
        }
    }
}

extension RecordViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,
                                 UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectListCell.identifier, for: indexPath) as? SelectListCell else {
            return UICollectionViewCell()
        }
        cell.cellLabel.text = selectList[indexPath.row]
        selectSectorView.isHidden = true
        selectColorView.isHidden = true
        if (indexPath.row == 3) { cell.dividerLabel.text = "" }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellLabel: UILabel = {
            let label = UILabel()
            label.text = selectList[indexPath.item]
            label.font = UIFont(name: "Roboto-Bold", size: 15)
            label.sizeToFit()
            return label
        }()
        let size = cellLabel.frame.size
        return CGSize(width: size.width + 3, height: size.height + 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectListViewIndex = indexPath.row
        if (indexPath.row == 0) {
            selectPlaceView.isHidden = false
            selectSectorView.isHidden = true
        } else if (indexPath.row == 1) {
            selectPlaceView.isHidden = true
            selectSectorView.isHidden = false
            selectColorView.isHidden = true
        } else if (indexPath.row == 2) {
            selectPlaceView.isHidden = true
            selectSectorView.isHidden = true
            selectColorView.isHidden = false
        } else if (indexPath.row == 3) {
            selectPlaceView.isHidden = true
        }
    }
}

