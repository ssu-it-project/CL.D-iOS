//
//  NotificationCenterHandler.swift
//  CLD
//
//  Created by 김규철 on 2023/11/09.
//

import Foundation
import RxSwift

protocol NotificationCenterHandler {
    var name: Notification.Name { get }
}

extension NotificationCenterHandler {
    func addObserver() -> Observable<Any?> {
        return NotificationCenter.default.rx.notification(name).map { $0.object }
    }

    func post(object: Any? = nil) {
        NotificationCenter.default.post(name: name, object: object, userInfo: nil)
    }
}

enum NotificationCenterManager: NotificationCenterHandler {
    case refreshVideoCell

    var name: Notification.Name {
        switch self {
        case .refreshVideoCell:
            return Notification.Name("NotificationCenterManager.refreshVideoCell")
        }
    }
}
