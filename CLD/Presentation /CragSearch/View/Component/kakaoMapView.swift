//
//  kakaoMapView.swift
//  CLD
//
//  Created by 김규철 on 2023/09/05.
//

import UIKit

final class kakaoMapView: UIView {
    
    private let mapView: UIView = {
        let view = UIView()
        view.backgroundColor = .ChipPink
        return view
    }()
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.font = UIFont(name: "Roboto-Bold", size: 15)
        label.numberOfLines = 2
        label.textColor = .black    
        return label
    }()
    private let phoneNumberLabel: UILabel = {
        let UILabel = UILabel()
        UILabel.sizeToFit()
        UILabel.font = UIFont(name: "Roboto-Medium", size: 15)
        UILabel.textColor = .CLDDarkGray
        return UILabel
    }()
    private let videoButton: UIButton = {
        let button = UIButton()
        button.setTitle("길찾기", for: .normal)
        button.setTitleColor(.CLDBlack, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 13)
        button.clipsToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .CLDGray
        setHierarchy()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        videoButton.layer.cornerRadius = 11
        self.layer.cornerRadius = 11
    }
    
    private func setHierarchy() {
        addSubviews(mapView, addressLabel, phoneNumberLabel, videoButton)
    }
    
    private func setConstraints() {
        mapView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(158)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(15)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(10).priority(.high)
        }
        
        phoneNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(6)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(10).priority(.high)
            make.height.equalTo(addressLabel.snp.height)
        }
        
        videoButton.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(17)
            make.bottom.equalToSuperview().inset(10)
            make.height.equalTo(30)
        }
    }
}

extension kakaoMapView {
    func configurationVIew(_ detailPlaceVO: DetailPlaceVO) {
        addressLabel.text = detailPlaceVO.addressName
        phoneNumberLabel.text = detailPlaceVO.phone
    }
}
