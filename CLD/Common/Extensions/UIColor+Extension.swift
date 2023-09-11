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
    
    static var CLDDarkDarkGray: UIColor {
        return UIColor(hex: "#515151")
    }
    
    static var CLDBlack: UIColor {
        return UIColor(hex: "#000000")
    }
    
    static var ChipWhite: UIColor {
        return UIColor(hex: "#F5F5F5")
    }
    
    static var ChipGray: UIColor {
        return UIColor(hex: "#D9D9D9")
    }
    
    static var ChipBlack: UIColor {
        return UIColor(hex: "#474747")
    }
    
    static var ChipBlue: UIColor {
        return UIColor(hex: "#5CABF4")
    }
    
    static var ChipRed: UIColor {
        return UIColor(hex: "#C34F4F")
    }
    
    static var ChipBrown: UIColor {
        return UIColor(hex: "#A46C54")
    }
    
    static var ChipPink: UIColor {
        return UIColor(hex: "#FFA9C8")
    }
    
    static var ChipGreen: UIColor {
        return UIColor(hex: "#91BA5C")
    }
    
    static var ChipPurple: UIColor {
        return UIColor(hex: "#A877F7")
    }
    
    static var ChipOrange: UIColor {
        return UIColor(hex: "#E69255")
    }
    
    static var ChipYellow: UIColor {
        return UIColor(hex: "#F0D575")
    }

    static var KakaoYellow: UIColor {
        return UIColor(hex: "#FEE500")
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
