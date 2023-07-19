//
//  UIStackView+Extension.swift
//  CLD
//
//  Created by 김규철 on 2023/07/18.
//

import UIKit.UIStackView

extension UIStackView {
     func addArrangedSubviews(_ views: UIView...) {
         for view in views {
             self.addArrangedSubview(view)
         }
     }
}
