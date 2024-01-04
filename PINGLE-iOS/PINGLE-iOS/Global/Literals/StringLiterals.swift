//
//  StringLiterals.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 12/27/23.
//

import Foundation

enum StringLiterals {
    
    // 필요한 enum을 만들어서 사용해주세요
    // 사용예시: titleLabel.text = StringLiterals.TabBar.home
    
    enum Onboarding {
        enum ButtonTitle {
            static let appleLogin = "Apple로 시작하기"
            static let existingOrganization = "기존 단체\n입장하기"
            static let makeOrganization = "신규 단체\n개설하기"
        }
        
        enum ExplainTitle {
            static let onboarding = "핑글에 오신걸\n환영합니다!"
        }
    }
    
    enum TabBar {
        enum ItemTitle {
            static let home = "홈"
            static let recommend = "추천"
            static let addPingle = "추가"
            static let myPingle = "마이핑글"
            static let setting = "설정"
        }
    }
    
    enum Metting {
        enum MettingGuide {
            static let guideTitle = "새로운 핑글을\n개최해보아요!"
            static let guideSubTitle = "어쩌구 번개를 개최하고\n어쩌구 번개를 개최하고"
            static let buttonTitle = "핑글 개최하러 가기"
        }
    }
}
