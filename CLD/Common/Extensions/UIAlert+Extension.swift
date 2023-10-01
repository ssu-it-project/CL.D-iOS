//
//  UIAlert+Extension.swift
//  CLD
//
//  Created by 이조은 on 2023/09/30.
//

import UIKit

extension BaseViewController {
    func createOKAlert(_ title: String, _ message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(okAction)

        return alertController
    }
    func createBasicAlert(_ title: String, _ message: String, _ okLabel: String, action: (() -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okLabel, style: .destructive) { _ in
            action?()
        }
        let cancelAction = UIAlertAction(title: "취소", style: .default)
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)

        return alertController
    }
}
