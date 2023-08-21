//
//  PostRecordViewController.swift
//  CLD
//
//  Created by 이조은 on 2023/08/04.
//

import UIKit

import SnapKit
import Photos

final class PostRecordViewController: BaseViewController {
    var postRecordDic: Dictionary<String, Any> = [:]
    var asset: PHAsset!
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    
    let postRecordView = PostRecordView()
    let successRecordView = SuccessRecordView()
    
    let recordButton: UIButton = {
        let button = UIButton()
        button.setTitle("기록하기", for: .normal)
        button.setTitleColor(.CLDBlack, for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 15)
        button.semanticContentAttribute = .forceLeftToRight
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(postRecord), for: .touchUpInside)
        return button
    }()
    
    @objc private func postRecord () {
        print("기록하기")
        postRecordView.isHidden = true
        recordButton.isHidden = true
        successRecordView.isHidden = false
    }
    
    @objc func backPage() {
        viewWillDisappear(false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        successRecordView.isHidden = true
        
        postRecordData(postRecordDic)
    }
    
    func postRecordData(_ postRecordDic: Dictionary<String, Any> ) {
        postRecordView.placeLabel.text = postRecordDic["place"] as? String
        postRecordView.sectorLabel.text = postRecordDic["sector"] as? String
        postRecordView.colorLabel.text = postRecordDic["color"] as? String
        switch postRecordView.colorLabel.text {
        case "흰색":
            postRecordView.colorCircle.layer.backgroundColor = UIColor.white.cgColor
        case "회색":
            postRecordView.colorCircle.layer.backgroundColor = UIColor.ChipGray.cgColor
        case "검정":
            postRecordView.colorCircle.layer.backgroundColor = UIColor.ChipBlack.cgColor
        case "파랑":
            postRecordView.colorCircle.layer.backgroundColor = UIColor.ChipBlue.cgColor
        case "빨강":
            postRecordView.colorCircle.layer.backgroundColor = UIColor.ChipRed.cgColor
        case "갈색":
            postRecordView.colorCircle.layer.backgroundColor = UIColor.ChipBrown.cgColor
        case "핑크":
            postRecordView.colorCircle.layer.backgroundColor = UIColor.ChipPink.cgColor
        case "초록":
            postRecordView.colorCircle.layer.backgroundColor = UIColor.ChipGreen.cgColor
        case "보라":
            postRecordView.colorCircle.layer.backgroundColor = UIColor.ChipPurple.cgColor
        case "주황":
            postRecordView.colorCircle.layer.backgroundColor = UIColor.ChipOrange.cgColor
        case "노랑":
            postRecordView.colorCircle.layer.backgroundColor = UIColor.ChipYellow.cgColor
        default :
            postRecordView.colorCircle.layer.backgroundColor = UIColor.CLDLightGray.cgColor
        }
        
        let asset: PHAsset! = postRecordDic["video"] as? PHAsset
        imageManager.requestImage(for: asset, targetSize: CGSize(width: 217, height: 212),
                                  contentMode: .aspectFill,
                                  options: nil,
                                  resultHandler: { image, _ in
            self.postRecordView.thumbnailView.image = image
            self.successRecordView.thumbnailView.image = image
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func setHierarchy() {
        self.view.addSubviews(postRecordView,recordButton,successRecordView)
    }
    
    override func setConstraints() {
        postRecordView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.leading.trailing.equalToSuperview()
        }
        recordButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(98)
            $0.width.equalTo(55)
            $0.height.equalTo(18)
            $0.centerX.equalToSuperview()
        }
        successRecordView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
}
