//
//  ProfileSettingViewController.swift
//  CLD
//
//  Created by 이조은 on 2023/09/14.
//

import UIKit

import SnapKit

class ProfileSettingViewController: BaseViewController {
    let profileSettingView = ProfileSettingView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationItem.title = "프로필 설정"
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }

    override func setHierarchy() {
        self.view.addSubview(profileSettingView)
    }

    override func setConstraints() {
        profileSettingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

