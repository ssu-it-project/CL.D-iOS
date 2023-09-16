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
    
    func convertToKoreanDateFormat() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "yyyy.MM.dd"
            dateFormatter.timeZone = TimeZone(abbreviation: "KST")
            
            return dateFormatter.string(from: date)
        }
        
        return nil
    }
    
    func convertDistanceToKilometers() -> String? {
        guard let distanceDouble = Double(self) else {
            return nil
        }
        
        let distanceInKilometers = distanceDouble / 1000.0
        return String(format: "%.1f km", distanceInKilometers)
    }
}
