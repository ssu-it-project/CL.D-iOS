//
//  RobotoFont.swift
//  CLD
//
//  Created by 이조은 on 2023/09/17.
//

import UIKit

enum RobotoFont: String {
    case Thin = "Roboto-Thin"
    case Light = "Roboto-Light"
    case Regular = "Roboto-Regular"
    case Medium = "Roboto-Medium"
    case Bold = "Roboto-Bold"
    case Black = "Roboto-Black"

    func of(size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }

    static func thin(size: CGFloat) -> UIFont {
        return RobotoFont.Thin.of(size: size)
    }
    static func light(size: CGFloat) -> UIFont {
        return RobotoFont.Light.of(size: size)
    }
    static func regular(size: CGFloat) -> UIFont {
        return RobotoFont.Regular.of(size: size)
    }
    static func medium(size: CGFloat) -> UIFont {
        return RobotoFont.Medium.of(size: size)
    }
    static func bold(size: CGFloat) -> UIFont {
        return RobotoFont.Bold.of(size: size)
    }
    static func black(size: CGFloat) -> UIFont {
        return RobotoFont.Black.of(size: size)
    }
}
