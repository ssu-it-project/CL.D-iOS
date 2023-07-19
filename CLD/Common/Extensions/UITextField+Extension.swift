//
//  UITextField+Extension.swift
//  CLD
//
//  Created by 김규철 on 2023/07/18.
//

import UIKit

extension UITextField {
    
    /// left: 왼쪽 패딩 너비
    /// right: 오른쪽 패딩 너비
    func addPadding(left: CGFloat? = nil, right: CGFloat? = nil) {
        if let leftPadding = left {
            leftView = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: 0))
            leftViewMode = .always
        }
        if let rightPadding = right {
            rightView = UIView(frame: CGRect(x: 0, y: 0, width: rightPadding, height: 0))
            rightViewMode = .always
        }
    }
    
    /// 자간(글자 한개 한개 사이) 설정
    func setCharacterSpacing(_ spacing: CGFloat) {
        let attributedString = NSMutableAttributedString(string: self.text ?? "")
        attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSMakeRange(0, attributedString.length))
        self.attributedText = attributedString
    }
    
}
