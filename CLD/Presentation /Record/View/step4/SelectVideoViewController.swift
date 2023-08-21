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
    var asset: PHAsset!
    
    private let dotDivider: UIImageView = {
        let view = UIImageView()
        view.image = ImageLiteral.dotDivider
        view.tintColor = .CLDDarkDarkGray
        view.backgroundColor = nil
        return view
    }()
    
    var fetchResult: PHFetchResult<PHAsset>!
    //이미지를 로드해올 친구
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    let cellIdentifier: String = "PhotoCollectionViewCell"
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let changes = changeInstance.changeDetails(for: fetchResult)
        else { return }
        
        fetchResult = changes.fetchResultAfterChanges
        
        //변화된것이 있으면 이미지를 다시 불러온다.
        OperationQueue.main.addOperation {
            self.selectCollectionView.reloadData()
        }
    }
    
    func requestCollection() {
        // 카메라로 찍으면 저장되는
        let cameraRoll: PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        guard let cameraRollCollection = cameraRoll.firstObject else {
            return
        }
        
        let fetchOptions = PHFetchOptions()
        //최신순으로 sort
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        self.fetchResult = PHAsset.fetchAssets(in: cameraRollCollection, options: fetchOptions)
    }
    
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
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 15)
        button.semanticContentAttribute = .forceLeftToRight
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        button.addTarget(SelectVideoViewController.self, action: #selector(nextView), for: .touchUpInside)
        return button
    }()
    @objc private func nextView () {
        finalRecordDic["video"] = asset
        print("finalRecordDic: \(finalRecordDic)")
        if ( finalRecordDic["place"] as! String != "" && finalRecordDic["sector"] as! String != "" && finalRecordDic["color"] as! String != "" && finalRecordDic["video"] != nil) {
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
            //다시 응답
            PHPhotoLibrary.requestAuthorization({ (status) in
                switch status {
                case .authorized:
                    print("사용자가 허용함")
                    self.requestCollection()
                    OperationQueue.main.addOperation {
                        self.selectCollectionView.reloadData()
                    }
                case .denied:
                    print("사용자가 불허함")
                default: break
                }
            })
        case .restricted:
            print("접근 제한")
        case .denied:
            print("접근 불허")
        case .authorized:
            print("접근 허가됨")
            self.requestCollection()
            OperationQueue.main.addOperation {
                self.selectCollectionView.reloadData()
            }
        case .limited:
            print("limited")
        @unknown default:
            print("unknown default")
        }
        
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
            $0.width.equalTo(28)
            $0.height.equalTo(18)
        }
    }
}

extension SelectVideoViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,
                                      UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return self.fetchResult?.count ?? 0
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        let asset: PHAsset = fetchResult.object(at: indexPath.row)
        
        //실질적인 이미지 요청
        imageManager.requestImage(for: asset, targetSize: CGSize(width: 83, height: 81), contentMode: .aspectFill, options: nil, resultHandler: { image, _ in
            cell.backgroundVideo.image = image
        })
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index: IndexPath = indexPath
        asset = self.fetchResult[index.row]
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
            //지원할 크기 지정
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
