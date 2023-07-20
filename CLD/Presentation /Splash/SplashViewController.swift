//
//  SplashViewController.swift
//  CLD
//
//  Created by 이조은 on 2023/07/20.
//

import UIKit
import SnapKit

final class SplashViewController: UIViewController {

    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cldLogo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
        setProperties()
        setLayouts()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //makeAnitmation()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func makeAnitmation() {
        UIView.animate(withDuration: 4) {
            self.logoImageView.alpha = 0
        }
    }

    private func setProperties() {
        view.backgroundColor = .white
    }

    private func setLayouts() {
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(148)
            $0.height.equalTo(95)
            $0.width.equalTo(78)
            $0.top.equalToSuperview().inset(323)
        }
    }
}
