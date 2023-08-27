//
//  Date+Extension.swift
//  CLD
//
//  Created by 김규철 on 2023/08/28.
//

import Foundation

extension Date {
    static func defaultFormattedString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.string(from: Date())
    }
}
