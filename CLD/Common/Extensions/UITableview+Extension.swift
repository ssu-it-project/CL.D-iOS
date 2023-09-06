//
//  UITableview+Extension.swift
//  CLD
//
//  Created by 이조은 on 2023/09/05.
//

import Foundation

import UIKit

extension UITableView {
    func setEmptyMessage(_ message: String) {
        let messageLabel: UILabel = {
            let label = UILabel()
            label.text = message
            label.font = UIFont(name: "AppleSDGothicNeoR00", size: 14.0)
            label.textColor = .lightGray
            label.numberOfLines = 0;
            label.textAlignment = .center;
            return label
        }()
        self.backgroundView = messageLabel
    }

    func restore() {
        self.backgroundView = nil
    }
}
