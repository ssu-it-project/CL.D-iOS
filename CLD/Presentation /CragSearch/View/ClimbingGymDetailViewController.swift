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
        stackView.addArrangedSubviews(kakaoMapContentView, videoView)
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    private let videoView = moreVideosView()
    private let kakaoMapContentView = kakaoMapView()
    
    private var viewModel: ClimbingGymDetailViewModel
    
    init(viewModel: ClimbingGymDetailViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        videoView.snp.makeConstraints { make in
            make.height.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.59)
        }
    }
    
    override func setViewProperty() {
        super.setViewProperty()
    }
}
