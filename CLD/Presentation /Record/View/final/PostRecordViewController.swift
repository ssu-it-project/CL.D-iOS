//
//  PostRecordViewController.swift
//  CLD
//
//  Created by 이조은 on 2023/08/04.
//

import UIKit

import SnapKit
import Photos
import LightCompressor

final class PostRecordViewController: BaseViewController {
    var postRecordDic: Dictionary<String, Any> = [:]
    var asset: PHAsset!
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    
    let postRecordView = PostRecordView()
    let successRecordView = SuccessRecordView()

    private var compression: Compression?
    private var compressedPath: URL?
    private var destinationPath = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("compressed.mp4")
    
    let recordButton: UIButton = {
        let button = UIButton()
        button.setTitle("기록하기", for: .normal)
        button.setTitleColor(.CLDBlack, for: .normal)
        button.titleLabel?.font = RobotoFont.Medium.of(size: 15)
        button.semanticContentAttribute = .forceLeftToRight
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(postRecordButton), for: .touchUpInside)
        return button
    }()
    
    @objc private func postRecordButton () {
        postRecordView.startLoadingIndicator()
        let place = postRecordDic["place"] as! String
        let climbing_gym_id = postRecordDic["climbing_gym_id"] as! String
        let content = postRecordView.getTextView()
        let sector = postRecordDic["sector"] as! String
        let level = postRecordDic["colorText"] as! String
        let asset: PHAsset! = postRecordDic["thumbnail"] as? PHAsset
        var video: URL = postRecordDic["videoURL"] as! URL
        // print("Original size: \(video.fileSizeInMB())")
        // print("=== destinationPath: \(destinationPath)")

        let videoCompressor = LightCompressor()
        compression = videoCompressor.compressVideo(videos: [.init(source: video, destination: destinationPath, configuration: .init(quality: VideoQuality.low, videoBitrateInMbps: 5, disableAudio: false, keepOriginalResolution: true))],
                                                    progressQueue: .main,
                                                    progressHandler: { progress in
            DispatchQueue.main.async { [unowned self] in
                // Handle progress- "\(String(format: "%.0f", progress.fractionCompleted * 100))%"
            }},
                                                    completion: {[weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .onSuccess(let index, let path):
                self.compressedPath = path
                video = path
                // print("Size after compression: \(video.fileSizeInMB())")
            case .onStart:
                print("onStart")
            case .onFailure(let index, let error):
                print("=== error: \(error)")
                print("onFailure")
            case .onCancelled:
                print("Cancelled")
            }
        })
        // print("==== place: \(place), climbing_gym_id: \(climbing_gym_id), content: \(content), sector: \(sector), color: \(level), video: \(asset), videoURL: \(video)")
        postRecord(climbing_gym_id, content, sector, level, video, "480")
    }
    
    @objc func backPage() {
        viewWillDisappear(false)
    }

    func postRecordData(_ postRecordDic: Dictionary<String, Any> ) {
        let place = postRecordDic["place"] as! String
        let sector = postRecordDic["sector"] as! String
        let color = postRecordDic["color"] as! ColorChipName
        let colorText = postRecordDic["colorText"] as! String

        let asset: PHAsset! = postRecordDic["thumbnail"] as? PHAsset
        imageManager.requestImage(for: asset, targetSize: CGSize(width: 217, height: 212),
                                  contentMode: .aspectFill,
                                  options: nil,
                                  resultHandler: { image, _ in
            let thumbnailImage: UIImage = image!
            self.successRecordView.setSuccessRecord(thumbnailImage)
            self.postRecordView.setPostRecord(thumbnailImage, place, sector, color, colorText)
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

extension PostRecordViewController {
    func postRecord(_ climbing_gym_id: String,_ content: String,_ sector: String,_ level: String,_ video: URL, _ resolution: String) {
        PostRecordService.shared.postRecord(climbing_gym_id: climbing_gym_id, content: content, sector: sector, level: level, video: video, resolution: resolution) { result in
            switch result {
            case .success(let response):
                self.postRecordView.isHidden = true
                self.recordButton.isHidden = true
                self.postRecordView.stopLoadingIndicator()
                self.successRecordView.isHidden = false
                try? FileManager.default.removeItem(at: self.destinationPath)
                guard let data = response as? BlankDataResponse else { return }
            case .requestErr(let errorResponse):
                dump(errorResponse)
                guard let data = errorResponse as? ErrorResponse else { return }
                print(data)
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            case .pathErr:
                print("pathErr")
            }
        }
    }
}
