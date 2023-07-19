//
//  UIView+Extension.swift
//  CLD
//
//  Created by 김규철 on 2023/07/19.
//

import UIKit

extension UIView {

    // DeviceWidth 반환
    func getDeviceWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    // DeviceHeight 반환
    func getDeviceHeight() -> CGFloat {
        return UIScreen.main.bounds.height
    }
    
    // 뷰 모서리 cornerRadius 설정
    // maskedCorners는 radius를 적용할 코너 지정함
    // cornerView.roundCorners(cornerRadius: 50, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
    func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }

}
