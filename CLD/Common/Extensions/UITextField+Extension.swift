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
    
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 31))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    
    /// 왼쪽 이미지 넣기 (CLDGray)
    func addLeftImageGray(image: UIImage) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 31))
        let letfImage = UIImageView(frame:CGRect(x: 8, y: 9, width: 13, height: 13))
        letfImage.image = image.resize(newWidth: CGFloat(13))
        letfImage.image = letfImage.image?.withRenderingMode(.alwaysTemplate)
        letfImage.tintColor = .CLDGray
        letfImage.backgroundColor = nil
        paddingView.addSubview(letfImage)
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    /// 왼쪽 이미지 넣기 (CLDDarkGray)
    func addLeftImageDarkGray(image: UIImage) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 31))
        let letfImage = UIImageView(frame:CGRect(x: 8, y: 9, width: 18, height: 16))
        letfImage.image = image.resize(newWidth: CGFloat(18))
        letfImage.image = letfImage.image?.withRenderingMode(.alwaysTemplate)
        letfImage.tintColor = .CLDDarkDarkGray
        letfImage.backgroundColor = nil
        paddingView.addSubview(letfImage)
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
}
