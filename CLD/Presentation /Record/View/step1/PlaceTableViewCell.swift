//
//  PlaceTableViewCell.swift
//  CLD
//
//  Created by 이조은 on 2023/08/29.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {
    static let identifier = "PlaceTableViewCell"

    private let customView: UIView =  {
        let contentView = UIView()
        return contentView
    }()
    private let placeIcon: UIImageView = {
        let iconView = UIImageView()
        iconView.image = ImageLiteral.searchIcon.withRenderingMode(.alwaysTemplate)
        iconView.tintColor = .CLDDarkGray
        return iconView
    }()
    let placeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 15)
        label.text = "장소장소장소"
        label.textColor = .CLDDarkGray
        label.backgroundColor = .clear
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(customView)
        customView.addSubviews(placeIcon, placeLabel)
        
        setUpLayouts()
    }

    func setUpLayouts() {
        customView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(20)
        }
        placeIcon.snp.makeConstraints {
            $0.size.equalTo(13)
            $0.leading.equalToSuperview().inset(6)
            $0.centerY.equalToSuperview()
        }
        placeLabel.snp.makeConstraints {
            $0.leading.equalTo(placeIcon.snp.trailing).offset(4)
            $0.centerY.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("")
    }
}
