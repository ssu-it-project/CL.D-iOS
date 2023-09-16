//
//  DeviceUUID.swift
//  CLD
//
//  Created by 김규철 on 2023/08/27.
//

import UIKit

class DeviceUUID {

    /**
     # getDeviceUUID
     - Note: 디바이스 고유 넘버 반환
     */
    static func getDeviceUUID() -> String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
}
