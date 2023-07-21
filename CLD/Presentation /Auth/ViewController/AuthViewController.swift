//
//  AuthViewController.swift
//  CLD
//
//  Created by 이조은 on 2023/07/19.
//

import UIKit

import SnapKit

final class AuthViewController: BaseViewController {
    let signView = SignView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setHierarchy() {
        self.view.addSubview(signView)
    }
    
    internal override func setConstraints() {
        signView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
