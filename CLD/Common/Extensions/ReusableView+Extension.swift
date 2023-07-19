//
//  ReusableView+Extension.swift
//  CLD
//
//  Created by 김규철 on 2023/07/18.
//

import UIKit.UIView

protocol ReusableView: AnyObject {}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
