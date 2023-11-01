//
//  SelectVideoViewController.swift
//  CLD
//
//  Created by 이조은 on 2023/08/04.
//

import UIKit

import SnapKit
import Photos

final class SelectVideoViewController: BaseViewController {
    var finalRecordDic: Dictionary<String, Any> = [:]
    var videoUrls: [URL] = []
    var videoURL: URL!
    var assetInfo: PHAsset!

    var fetchResult: PHFetchResult<PHAsset>!
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    var videos: [PHAsset] = []
    let cellIdentifier: String = "PhotoCollectionViewCell"
    
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
        collectionView.register(PhotoCollectionViewCell.self,
                                forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)

        return collectionView
    }()

    let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.CLDBlack, for: .normal)
        button.titleLabel?.font = RobotoFont.Medium.of(size: 15)
        button.semanticContentAttribute = .forceLeftToRight
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(nextView), for: .touchUpInside)

        return button
    }()

    @objc private func nextView () {
        finalRecordDic["thumbnail"] = assetInfo
        finalRecordDic["videoURL"] = videoURL
        // print("finalRecordDic: \(finalRecordDic)")
        if ( finalRecordDic["place"] as? String != "" && finalRecordDic["sector"] as? String != "" && finalRecordDic["color"] as? ColorChipName != nil && finalRecordDic["videoURL"] != nil) {
            presentModalBtnTap()
        } else {
            let alert = UIAlertController(title: "확인", message: """
                                          클라이밍장, 섹터, 난이도 색상, 영상 중에
                                          입력되지 않은 값이 없는지 확인해주세요.
                                          """, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default) { _ in
                return
            }
            alert.addAction(okAction)
            present(alert, animated: true)
        }
    }

    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let changes = changeInstance.changeDetails(for: fetchResult)
        else { return }

        fetchResult = changes.fetchResultAfterChanges

        OperationQueue.main.addOperation {
            self.selectCollectionView.reloadData()
        }
    }

    func fetchVideos() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.video.rawValue)
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

        fetchResult = PHAsset.fetchAssets(with: fetchOptions)

        for index in 0..<fetchResult.count {
            videos.append(fetchResult.object(at: index))
        }

        OperationQueue.main.addOperation {
            self.selectCollectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        self.view.backgroundColor = .white

        selectCollectionView.delegate = self
        selectCollectionView.dataSource = self

        setHierarchy()
        setConstraints()

        //사용자가 사진첩에 접근을 허가 했는지 확인
        let photoAurhorizationStatus = PHPhotoLibrary.authorizationStatus()

        switch photoAurhorizationStatus {
        case .notDetermined:
            print("아직 응답하지 않음")
            PHPhotoLibrary.requestAuthorization({ (status) in
                switch status {
                case .authorized:
                    print("사용자가 허용함")
                    self.fetchVideos()
                case .denied:
                    print("사용자가 불허함")
                default: break
                }
            })
        case .restricted:
            print("접근 제한")
        case .denied:
            print("접근 불허")
            let alert = UIAlertController(title: "권한 없음", message: """
                                          비디오 접근 권한이 없습니다.
                                          설정 > 개인 정보 보호 > 사진에서
                                          권한을 추가하세요.
                                          """, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "설정", style: .default) { _ in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                return
            }
            let cancelAction = UIAlertAction(title: "취소", style: .default) { _ in
                return
            }
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            present(alert, animated: true)
        case .authorized:
            print("접근 허가됨")
            self.fetchVideos()
        case .limited:
            print("limited")
        @unknown default:
            print("unknown default")
        }

        PHPhotoLibrary.shared().register(self)
        setPhoto()
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
            $0.bottom.equalToSuperview().inset(56)
            $0.centerX.equalToSuperview()
        }
    }
}

extension SelectVideoViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,
                                      UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("====: \(self.fetchResult!.count)")
        print("====video: \(videos.count)")
        if (self.fetchResult!.count == 0) {
            selectCollectionView.setEmptyMessage("""
                                                갤러리에 동영상이 없습니다.
                                                동영상을 찍고 다시 등반을 기록해주세요.
                                                """)
            return 0
        } else {
            if (videos.count >= 12) {
                return 12
            }
        }
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        let videoAsset = videos[indexPath.row]

        DispatchQueue.global().async {
            PHImageManager.default().requestAVAsset(forVideo: videoAsset, options: nil) { [self] (avAsset, _, _) in
                if let urlAsset = avAsset as? AVURLAsset {
                    let url = urlAsset.url
                    videoUrls.append(url)

                    let assetDuration = urlAsset.duration
                    let seconds = CMTimeGetSeconds(assetDuration)

                    let imageGenerator = AVAssetImageGenerator(asset: urlAsset)
                    imageGenerator.appliesPreferredTrackTransform = true
                    let time = CMTime(seconds: 2.0, preferredTimescale: 60)
                    DispatchQueue.main.async {
                        do {
                            let cgImage = try imageGenerator.copyCGImage(at: time, actualTime: nil)
                            let thumbnailImage = UIImage(cgImage: cgImage)

                            cell.backgroundVideo.image = thumbnailImage
                            cell.timeLabel.text = String(round(seconds)/100)
                        } catch {
                            print("Error generating thumbnail: \(error)")
                        }
                    }

                }
            }
        }

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
        let index: IndexPath = indexPath
        assetInfo = self.videos[index.row]
        videoURL = self.videoUrls[index.row]
    }
}

extension SelectVideoViewController: PHPhotoLibraryChangeObserver {
    func setPhoto() {
        PHPhotoLibrary.shared().register(self)
    }
}

extension SelectVideoViewController: UISheetPresentationControllerDelegate {
    func presentModalBtnTap() {
        let vc = PostRecordViewController()
        vc.modalPresentationStyle = .pageSheet
        
        if let sheet = vc.sheetPresentationController {
            if #available(iOS 16.0, *) {
                sheet.detents = [.custom { context in
                    return context.maximumDetentValue * 0.9
                }]
            } else { sheet.detents = [.medium(), .large()] }
            sheet.delegate = self
            sheet.prefersGrabberVisible = true
        }
        vc.postRecordDic = finalRecordDic
        present(vc, animated: true, completion: nil)
    }
}
