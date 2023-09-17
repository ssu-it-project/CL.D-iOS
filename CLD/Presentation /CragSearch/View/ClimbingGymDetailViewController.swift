//
//  ClimbingGymDetailViewController.swift
//  CLD
//
//  Created by 김규철 on 2023/09/04.
//

import UIKit

import RxSwift
import RxCocoa

final class ClimbingGymDetailViewController: BaseViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubviews(kakaoMapContentView, morevideoView)
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    private let morevideoView = MoreVideosView()
    private lazy var kakaoMapContentView: KakaoMapView = {
        let kakaoMapView = KakaoMapView()
        kakaoMapView.mapView.delegate = self
        return kakaoMapView
    }()
    
    private var viewModel: ClimbingGymDetailViewModel
    
    init(viewModel: ClimbingGymDetailViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindAction()
    }
    
    override func Bind() {
        let input = ClimbingGymDetailViewModel.Input(viewDidLoadEvent: Observable.just(()).asObservable())
        let output = viewModel.transform(input: input)
        
        output.placeVO
            .withUnretained(self)
            .bind { owner, detailPlaceVO in
                owner.kakaoMapContentView.configurationVIew(detailPlaceVO)
            }
            .disposed(by: disposeBag)
        
        output.kakaoMapPoint
            .withUnretained(self)
            .bind { owner, mapPoint in
                let (latitude, longitude, gymTitle) = mapPoint
                owner.kakaoMapContentView.createPin(itemName: gymTitle, getla: longitude, getlo: latitude)
            }
            .disposed(by: disposeBag)
        
        output.gymTitle
            .withUnretained(self)
            .bind { owner, title in
                owner.title = title
            }
            .disposed(by: disposeBag)
        
        output.recordVideoURL
            .withUnretained(self)
            .bind { owner, recordVideoURL in
                owner.morevideoView.configureVideoURL(videoURL: recordVideoURL)
            }
            .disposed(by: disposeBag)
        
        output.recordVideoIsEmpty
            .withUnretained(self)
            .bind { owner, isEmpty in
                owner.morevideoView.handleHiddenVideoSampleImageView(isEmpty)
            }
            .disposed(by: disposeBag)
        
        output.recordLevel
            .withUnretained(self)
            .subscribe { owner, badge in
                let (level, sector) = badge
                owner.morevideoView.setLevelLabel(level: level, section: sector)
            }
            .disposed(by: disposeBag)
    }
    
    private func bindAction() {
        morevideoView.videoButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                let videoViewController = ClimbingGymVideoViewController(viewModel: ClimbingGymVideoViewModel(id: owner.viewModel.id, title: owner.title ?? "", useCase: DefaultClimbingGymVideoUseCase(gymsRepository: DefaultGymsRepository())))
        
                owner.navigationController?.pushViewController(videoViewController, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        let bookMarkBarButtonItem = UIBarButtonItem(image: ImageLiteral.bookMarkIcon, style: .plain, target: self, action: nil)
        bookMarkBarButtonItem.tintColor = .CLDBlack
        self.navigationItem.rightBarButtonItem = bookMarkBarButtonItem
    }
    
    override func setHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
    }
    
    override func setConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(26)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }
        
        kakaoMapContentView.snp.makeConstraints { make in
            make.height.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.4)
        }
        
        morevideoView.snp.makeConstraints { make in
            make.height.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.59)
        }
    }
    
    override func setViewProperty() {
        super.setViewProperty()
    }
}

extension ClimbingGymDetailViewController: MTMapViewDelegate {
    func mapView(_ mapView: MTMapView!, selectedPOIItem poiItem: MTMapPOIItem!) -> Bool {
        let url = URL(string: viewModel.placeIDURL)
        let kakaoMapAppstoreURL = URL(string: "https://apps.apple.com/us/app/id304608425")
        
        if UIApplication.shared.canOpenURL(URL(string:"kakaomap://")!){
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            return true
        } else {
            self.presentAlert(title: "카카오 맵 미설치", message: "카카오 맵이 설치되어 있지 않습니다. 앱스토어로 이동하시겠습니까?", okButtonTitle: "이동하기") {
                UIApplication.shared.open(kakaoMapAppstoreURL!, options: [:], completionHandler: nil)
            }
            return true
        }
    }
}
