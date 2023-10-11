//
//  CommunityViewController.swift
//  CLD
//
//  Created by 김규철 on 2023/07/20.
//

import UIKit

import SnapKit

class CommunityViewController: BaseViewController {
    private let CommunityLabel: UILabel = {
        let UILabel = UILabel()
        UILabel.sizeToFit()
        UILabel.font = RobotoFont.Regular.of(size: 16)
        UILabel.textColor = .CLDDarkGray
        UILabel.numberOfLines = 0
        UILabel.textAlignment = .center
        UILabel.text = "커뮤니티 페이지는 10월 23일에 공개됩니다."
        return UILabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setHierarchy() {
        self.view.addSubview(CommunityLabel)
    }

    override func setConstraints() {
        CommunityLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(200)
            $0.centerX.equalToSuperview()
        }
    }
}
