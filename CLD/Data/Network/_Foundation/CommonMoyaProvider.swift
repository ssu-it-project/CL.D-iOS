//
//  CommonMoyaProvider.swift
//  CLD
//
//  Created by 김규철 on 2023/08/26.
//

import Foundation
import Moya

class CommonMoyaProvider<T: TargetType>: MoyaProvider<T> {
    init() {
        super.init(session: Moya.Session(), plugins: [NetworkPlugin()])
    }
}
