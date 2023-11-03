//
//  ReportType.swift
//  CLD
//
//  Created by 김규철 on 2023/11/03.
//

import Foundation

enum ReportType: CaseIterable {
    case leakageImpersonationFraud
    case explicitContentInappropriateEncounter
    case defamationPoliticianInsultElection
    case inappropriateForums
    case trollingPranksSpam
    case harassmentInsults
    case commercialAdvertisingSales
    
    var title: String {
        switch self {
        case .leakageImpersonationFraud:
            return "유출/사칭/사기"
        case .explicitContentInappropriateEncounter:
            return "음란물/불건전한 만남 및 대화"
        case .defamationPoliticianInsultElection:
            return "정당/정치인 비하 및 선거운동"
        case .inappropriateForums:
            return "게시판 성격에 부적절함"
        case .trollingPranksSpam:
            return "낚시/놀람/도배"
        case .harassmentInsults:
            return "욕설/비하"
        case .commercialAdvertisingSales:
            return "상업적 광고 및 판매"
        }
    }
}
