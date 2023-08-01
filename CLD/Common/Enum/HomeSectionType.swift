//
//  HomeSectionType.swift
//  CLD
//
//  Created by 김규철 on 2023/07/30.
//

import Foundation

enum HomeSectionType: Int, CaseIterable {
    case badgeSection
    case videoBanner
    
    var title: String {
        switch self {
        case .badgeSection:
            return ""
        case .videoBanner:
            return "문제 풀이"
        }
    }
}
