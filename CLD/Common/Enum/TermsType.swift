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
    
    var url: String {
        switch self {
        case .termsOfUseRequired:
            return "https://cl-d.s3.ap-northeast-2.amazonaws.com/terms/64dceb920530156f20c6cb99.html"
        case .personalInfoCollectionRequired:
            return "https://cl-d.s3.ap-northeast-2.amazonaws.com/terms/64dcf036ce81c3226358cfc7.html"
        case .eventInfoConsent:
            return "https://cl-d.s3.ap-northeast-2.amazonaws.com/terms/64dcf036ce81c3226358cfc8.html"
        }
    }
    
    var id: String {
        switch self {
        case .termsOfUseRequired:
            return "64fd487f88371d14f7c20e69"
        case .personalInfoCollectionRequired:
            return "64fd487f88371d14f7c20e6a"
        case .eventInfoConsent:
            return "64fd487f88371d14f7c20e6b"
        }
    }
    
    func agreement(agree: Bool) -> Agreement {
        switch self {
        case .termsOfUseRequired:
            return Agreement(agreed: agree, id: TermsType.termsOfUseRequired.id)
        case .personalInfoCollectionRequired:
            return Agreement(agreed: agree, id: TermsType.personalInfoCollectionRequired.id)
        case .eventInfoConsent:
            return Agreement(agreed: agree, id: TermsType.eventInfoConsent.id)
        }
    }
}




