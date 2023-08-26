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

    func postRecordData(_ postRecordDic: Dictionary<String, Any> ) {
        let place = postRecordDic["place"] as! String
        let sector = postRecordDic["sector"] as! String
        let color = postRecordDic["color"] as! ColorChipName

        let asset: PHAsset! = postRecordDic["video"] as? PHAsset
        imageManager.requestImage(for: asset, targetSize: CGSize(width: 217, height: 212),
                                  contentMode: .aspectFill,
                                  options: nil,
                                  resultHandler: { image, _ in
            let thumbnailImage: UIImage = image!
            self.successRecordView.setSuccessRecord(thumbnailImage)
            self.postRecordView.setPostRecord(thumbnailImage, place, sector, color)
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        successRecordView.isHidden = true
        
        postRecordData(postRecordDic)
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
