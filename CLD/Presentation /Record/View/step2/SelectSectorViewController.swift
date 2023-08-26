//
//  SelectSectorViewController.swift
//  CLD
//
//  Created by 이조은 on 2023/08/01.
//

import UIKit

import SnapKit

final class SelectSectorViewController: BaseViewController {
    var sectorText: String = ""
    
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
    
    override func viewWillLayoutSubviews() {
        sectorText = sectorTextField.text ?? ""
    }

    override func setHierarchy() {
        self.view.addSubviews(dotDivider, sectorTextField)
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
    }
}
