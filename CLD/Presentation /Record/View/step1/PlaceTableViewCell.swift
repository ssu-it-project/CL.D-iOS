//
//  PlaceTableViewCell.swift
//  CLD
//
//  Created by 이조은 on 2023/08/29.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {
    static let identifier = "PlaceTableViewCell"

    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "장소"
        textField.font = UIFont(name: "Roboto-Regular", size: 15)
        textField.textColor = .CLDBlack
        textField.backgroundColor = .CLDLightGray
        textField.borderStyle = .none
        return textField
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        searchTextField.addLeftPadding()
        searchTextField.addLeftImageGray(image: ImageLiteral.searchIcon)

        self.contentView.addSubview(searchTextField)
        
        searchTextField.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(18)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("")
    }
}
