//
//  SelectSectorViewController.swift
//  CLD
//
//  Created by 이조은 on 2023/08/01.
//

import UIKit

import SnapKit

final class SelectSectorViewController: BaseViewController {
    private let dotDivider: UIImageView = {
        let view = UIImageView()
        view.image = ImageLiteral.dotDivider
        view.tintColor = .CLDDarkDarkGray
        view.backgroundColor = nil
        return view
    }()
    
    private let sectorTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "섹터를 입력해주세요."
        textField.font = UIFont(name: "Roboto-Regular", size: 15)
        textField.textColor = .CLDBlack
        textField.backgroundColor = .CLDLightGray
        return textField
    }()
    private let underLine: CALayer = {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: 30, width: 312, height: 1)
        border.backgroundColor = UIColor.CLDGold.cgColor
        return border
    }()
    let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.CLDBlack, for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 15)
        button.semanticContentAttribute = .forceLeftToRight
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(nextView), for: .touchUpInside)
        return button
    }()
    @objc private func nextView () {
        print("다음")
        // self.present(SelectSectorViewController(), animated: true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white

        sectorTextField.addLeftPadding()
        sectorTextField.layer.addSublayer((underLine))
        
        setHierarchy()
        setConstraints()
    }

    override func setHierarchy() {
        self.view.addSubviews(dotDivider, sectorTextField, nextButton)
    }
    
    override func setConstraints() {
        dotDivider.snp.makeConstraints {
            $0.top.equalToSuperview().inset(77)
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview().inset(19)
        }
        sectorTextField.snp.makeConstraints {
            $0.top.equalToSuperview().inset(92)
            $0.leading.equalToSuperview().inset(25)
            $0.width.equalTo(312)
            $0.height.equalTo(31)
        }
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(101)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(28)
            $0.height.equalTo(18)
        }
    }
}
