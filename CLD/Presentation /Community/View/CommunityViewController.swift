//
//  CommunityViewController.swift
//  CLD
//
//  Created by 김규철 on 2023/07/20.
//

import UIKit

final class CommunityViewController: BaseViewController {
    private let CommunityLabel: UILabel = {
        let UILabel = UILabel()
        UILabel.sizeToFit()
        UILabel.font = RobotoFont.Regular.of(size: 16)
        UILabel.textColor = .CLDDarkGray
        UILabel.numberOfLines = 0
        UILabel.textAlignment = .center
        UILabel.text = "커뮤니티 페이지는 11월 11일에 공개됩니다."
        return UILabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 16.0, *) {
            self.navigationItem.leftBarButtonItem?.isHidden = true
        }
    }

    override func setHierarchy() {
    }

    override func setConstraints() {
    }
}
