//
//  ClimbingGymTableViewCell.swift
//  CLD
//
//  Created by 김규철 on 2023/09/04.
//

import UIKit

import RxCocoa
import RxSwift
import Kingfisher

final class ClimbingGymTableViewCell: UITableViewCell {
    
    private let topLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    private let gymImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "videoCellProfleImage")
        imageView.clipsToBounds = true
        return imageView
    }()
    private let titleLabel: UILabel = {
        let UILabel = UILabel()
        UILabel.sizeToFit()
        UILabel.font = UIFont(name: "Roboto-ExtraBold", size: 12)
        UILabel.textColor = .black
        UILabel.text = "더클라이밍 마곡동"
        return UILabel
    }()
    private let addressLabel: UILabel = {
        let UILabel = UILabel()
        UILabel.sizeToFit()
        UILabel.font = UIFont(name: "Roboto-ExtraBold", size: 12)
        UILabel.textColor = .CLDDarkGray
        UILabel.text = "더클라이밍 마곡동 52 - 1"
        return UILabel
    }()
    private let vehicleAvailableBadge: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "videoCellProfleImage")
        return imageView
    }()
    private let parkingAvailableBadge: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "videoCellProfleImage")
        return imageView
    }()
    private lazy var parkingAvailableBadgeStackView: UIStackView = {
        let view = UIStackView()
        view.addArrangedSubviews(vehicleAvailableBadge, parkingAvailableBadge)
        view.axis = .horizontal
        view.spacing = 2
        view.distribution = .fillEqually
        return view
    }()
    private let locationLabel: UILabel = {
        let UILabel = UILabel()
        UILabel.sizeToFit()
        UILabel.font = UIFont(name: "Roboto-Bold", size: 12)
        UILabel.textColor = .black
        UILabel.text = "2.0 km"
        return UILabel
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        gymImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gymImageView.layer.cornerRadius = 3
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setHierarchy()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        addSubviews(topLineView, gymImageView, titleLabel, addressLabel, parkingAvailableBadgeStackView, locationLabel)
    }
    
    private func setConstraints() {
        topLineView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
        
        gymImageView.snp.makeConstraints { make in
            make.top.equalTo(topLineView.snp.bottom).offset(28)
            make.leading.equalToSuperview()
            make.width.equalTo(self.snp.height).multipliedBy(0.7)
            make.height.equalTo(self.snp.height).multipliedBy(0.7)
            make.bottom.equalToSuperview().inset(7)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(gymImageView.snp.top)
            make.leading.equalTo(gymImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(20).priority(.high)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalToSuperview().inset(20).priority(.high)
        }
        
        vehicleAvailableBadge.snp.makeConstraints { make in
            make.size.equalTo(17)
        }
        
        parkingAvailableBadgeStackView.snp.makeConstraints { make in
            make.leading.equalTo(gymImageView.snp.trailing).offset(5)
            make.bottom.equalToSuperview().inset(7)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20).priority(.high)
            make.centerY.equalTo(parkingAvailableBadgeStackView.snp.centerY)
            make.bottom.equalToSuperview().inset(7)
        }
    }
    
}

extension ClimbingGymTableViewCell {
    func configCell(row: ClimbingGymVO) {
        titleLabel.text = row.place.name
        addressLabel.text = row.place.addressName
        
        if !row.place.parking {
            parkingAvailableBadgeStackView.isHidden = true
        }
        
        locationLabel.text = "\(row.location.distance) km"
    }
}
