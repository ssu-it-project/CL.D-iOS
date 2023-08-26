//
//  ColorChipName.swift
//  CLD
//
//  Created by 이조은 on 2023/08/26.
//

import Foundation
import CoreGraphics
import UIKit

enum ColorChipName {
    case white
    case gray
    case black
    case blue
    case red
    case brown
    case pink
    case green
    case purple
    case orange
    case yellow
    case addColor

    func colorName() -> String {
        switch self {
        case .white:
                return "흰색"
        case .gray:
                return "회색"
        case .black:
                return "검정"
        case .blue:
                return "파랑"
        case .red:
                return "빨강"
        case .brown:
                return "갈색"
        case .pink:
                return "핑크"
        case .green:
                return "초록"
        case .purple:
                return "보라"
        case .orange:
                return "주황"
        case .yellow:
                return "노랑"
        case .addColor:
                return "추가"
        }
    }

    func colorChip() -> CGColor {
        switch self {
        case .white:
                return UIColor.white.cgColor
        case .gray:
                return UIColor.ChipGray.cgColor
        case .black:
                return UIColor.ChipBlack.cgColor
        case .blue:
                return UIColor.ChipBlue.cgColor
        case .red:
                return UIColor.ChipRed.cgColor
        case .brown:
                return UIColor.ChipBrown.cgColor
        case .pink:
                return UIColor.ChipPink.cgColor
        case .green:
                return UIColor.ChipGreen.cgColor
        case .purple:
                return UIColor.ChipPurple.cgColor
        case .orange:
                return UIColor.ChipOrange.cgColor
        case .yellow:
                return UIColor.ChipYellow.cgColor
        case .addColor:
                return UIColor.CLDLightGray.cgColor
        }
    }
}
