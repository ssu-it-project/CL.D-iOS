//
//  URL+Extension.swift
//  CLD
//
//  Created by 이조은 on 2023/09/10.
//

import UIKit

extension URL {
    func fileSizeInMB() -> String {
        let p = self.path

        let attr = try? FileManager.default.attributesOfItem(atPath: p)

        if let attr = attr {
            let fileSize = Float(attr[FileAttributeKey.size] as! UInt64) / (1024.0 * 1024.0)

            return String(format: "%.2f MB", fileSize)
        } else {
            return "Failed to get size"
        }
    }
}
