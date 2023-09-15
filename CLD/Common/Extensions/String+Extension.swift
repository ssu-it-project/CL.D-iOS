//
//  String+Extension.swift
//  CLD
//
//  Created by 김규철 on 2023/09/15.
//

import UIKit

extension String {
    func getColorForLevel() -> UIColor? {
        guard let colorLevel = LevelType(rawValue: self) else {
            return UIColor.lightGray
        }
        
        switch colorLevel {
        case .white:
            return UIColor.ChipWhite
        case .gray:
            return UIColor.ChipGray
        case .black:
            return UIColor.ChipBlack
        case .blue:
            return UIColor.ChipBlue
        case .red:
            return UIColor.ChipRed
        case .brown:
            return UIColor.ChipBrown
        case .pink:
            return UIColor.ChipPink
        case .green:
            return UIColor.ChipGreen
        case .purple:
            return UIColor.ChipPurple
        case .orange:
            return UIColor.ChipOrange
        case .yellow:
            return UIColor.ChipYellow
        }
    }

}
