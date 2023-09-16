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
    private let kakaoMapContentView = KakaoMapView()
    
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
    
    override func setNavigationBar() {
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
