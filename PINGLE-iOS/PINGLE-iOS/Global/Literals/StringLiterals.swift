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
            static let requestOrganization = "단체를 직접 추가해주세요"
        }
        
        enum ExplainTitle {
            static let onboarding = "핑글에 오신걸\n환영합니다!"
            static let searchOrganization = "속해있는 단체의\n이름을 알려주세요"
            static let bottomRequest = "찾는 단체가 없나요?"
            static let noResult = "검색 결과가 없어요"
        }
        
        enum NavigationTitle {
            static let searchOrganizationNavigation = "기존 단체 입장하기"
        }
        
        enum SearchBarPlaceholder {
            static let searchOrganizationPlaceholder = "단체 이름을 검색해보세요"
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
        
        enum MettingCategory {
            enum CategoryTitle {
                static let play = "PLAY"
                static let study = "STUDY"
                static let multi = "MULTI"
                static let others = "OTHERS"
            }
            
            enum ExplainCategory {
                static let playExplain = "설명 텍스트 미정"
                static let studyExplain = "열공, 열작업할 사람 모여라!"
                static let multiExplain = "설명 텍스트 미정"
                static let othersExplain = "설명 텍스트 미정"
            }
            
            enum ExitButton {
                static let exitButton = "나가기"
                static let exitLabel = "나중에 만드시겠어요?"
            }
        }
    }
    
    enum CTAButton {
        static let buttonTitle = "다음으로"
    }
}
