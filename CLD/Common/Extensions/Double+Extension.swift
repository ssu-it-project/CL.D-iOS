//
//  Double+Extension.swift
//  CLD
//
//  Created by 김규철 on 2023/09/15.
//

import Foundation

extension Double {
    func convertToKilometers() -> Double {
        return self / 1000.0
    }
    
    func formatToKilometersString() -> String {
        let kilometers = convertToKilometers()
        return String(format: "%.1f km", kilometers)
    }
}

