//
//  ClimbingGymDetailViewController.swift
//  CLD
//
//  Created by 김규철 on 2023/09/04.
//

import UIKit

final class ClimbingGymDetailViewController: BaseViewController {
    
    private let scrollView = UIScrollView()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubviews(videoView, locationTitleLabel, kakaoMapContentView)
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    private let videoView = moreVideosView()
    private let locationTitleLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.font = UIFont(name: "Roboto-Medium", size: 16)
        label.textColor = .black
        label.text = "위치 정보"
        return label
    }()
    private let kakaoMapContentView = kakaoMapView()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
    }
    
    override func setConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(26)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }
        
        videoView.snp.makeConstraints { make in
            make.height.equalTo(150)
        }
        
        kakaoMapContentView.snp.makeConstraints { make in
            make.height.equalTo(250)
        }
    }
    
    override func setViewProperty() {
        super.setViewProperty()
    }
    
    

}
