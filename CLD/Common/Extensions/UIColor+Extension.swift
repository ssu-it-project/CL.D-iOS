//
//  UIColor+Extension.swift
//  CLD
//
//  Created by 김규철 on 2023/07/19.
//

import UIKit

extension UIColor {
    static var CLDGold: UIColor {
        return UIColor(hex: "#E3B55F")
    }
    
    static var CLDLightYellow: UIColor {
        return UIColor(hex: "#F4E7B9")
    }
    
    static var CLDYellow: UIColor {
        return UIColor(hex: "#D9D9D9")
    }
    
    static var CLDOrange: UIColor {
        return UIColor(hex: "#F28C2E")
    }
    
    static var CLDGray: UIColor {
        return UIColor(hex: "#D2D4D7")
    }
    
    static var CLDLightGray: UIColor {
        return UIColor(hex: "#F5F5F5")
    }
    
    static var CLDMediumGray: UIColor {
        return UIColor(hex: "#5C5C5C")
    }
    
    static var CLDDarkGray: UIColor {
        return UIColor(hex: "#8F9194")
    }
    
    static var CLDBlack: UIColor {
        return UIColor(hex: "#000000")
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: alpha)
    }
}
