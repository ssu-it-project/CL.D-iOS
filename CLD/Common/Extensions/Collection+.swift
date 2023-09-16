//
//  Collection+.swift
//  CLD
//
//  Created by 김규철 on 2023/09/16.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
