//
//  UIVIewController+Extension.swift
//  CLD
//
//  Created by 김규철 on 2023/09/17.
//

import Foundation

typealias UIActionHandler = () -> Void

extension UIViewController {
    func presentAlert(title: String, message: String, okButtonTitle: String, buttonAction: UIActionHandler? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "닫기", style: .default, handler: nil)
        let okAction = UIAlertAction(title: okButtonTitle, style: .default) { _ in
            buttonAction?()
        }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func presentOkAlert(title: String, message: String, ButtonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: ButtonTitle, style: .default, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
