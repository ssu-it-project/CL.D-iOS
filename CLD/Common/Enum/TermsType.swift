//
//  TermsType.swift
//  CLD
//
//  Created by 김규철 on 2023/08/16.
//

import Foundation

enum TermsType: CaseIterable {
    case termsOfUseRequired
    case personalInfoCollectionRequired
    case eventInfoConsent
    
    var description: String {
        switch self {
            case .termsOfUseRequired:
                return "[필수] 클디 이용약관 동의"
            case .personalInfoCollectionRequired:
                return "[필수] 개인정보 수집 이용 동의"
            case .eventInfoConsent:
                return "[선택] 이벤트 알림 서비스 동의"
        }
    }
}




