//
//  PostRecordViewController.swift
//  CLD
//
//  Created by 이조은 on 2023/08/04.
//

import UIKit

import SnapKit

final class PostRecordViewController: BaseViewController {
    let postRecordView = PostRecordView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "새 게시물"
        label.textColor = .black
        label.font = UIFont(name: "Roboto-Regular", size: 15)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setHierarchy() {
        self.view.addSubviews(titleLabel,postRecordView)
    }
    
    override func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.width.equalTo(57)
            $0.height.equalTo(18)
            $0.centerX.equalToSuperview()
        }
        postRecordView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(44)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
}
