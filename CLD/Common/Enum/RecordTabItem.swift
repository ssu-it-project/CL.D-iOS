//
//  RecordTabItem.swift
//  CLD
//
//  Created by 이조은 on 2023/08/26.
//

import Foundation
import Tabman

enum RecordTabItem {
    case place
    case sector
    case color
    case video

    func changeTabItem() -> TMBarItemable {
        switch self {
        case .place:
            return TMBarItem(title: "클라이밍장")
        case .sector:
            return TMBarItem(title: "섹터")
        case .color:
            return TMBarItem(title: "난이도 색상")
        case .video:
            return TMBarItem(title: "영상")
        }
    }
}
