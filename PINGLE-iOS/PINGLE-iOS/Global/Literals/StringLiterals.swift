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
            static let inviteCodeTitle = "단체 정보를 확인하고\n초대 코드를 입력해주세요"
            static let meetingNumber = "개설된 모임 수"
            static let memberNumber = "총 인원"
            static let inviteCodeTextFieldTitle = "초대코드"
            static let infoMessage = "모임 개설자로부터 받은 초대 코드를 입력해주세요"
        }
        
        enum NavigationTitle {
            static let searchOrganizationNavigation = "기존 단체 입장하기"
        }
        
        enum SearchBarPlaceholder {
            static let searchOrganizationPlaceholder = "단체 이름을 검색해보세요"
            static let inviteCodePlaceholder = "영문+숫자 12자리"
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
            
            enum CategoryLabel {
                static let categoryTitleLabel = "개최할 핑글을\n선택해주세요"
            }
            
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
        
        enum MeetingIntroduction {
            static let introductionTitle = "개최할 핑글을\n소개해주세요"
            static let PINGLETitle = "핑글제목"
            static let PINGLEExplain = "이번 핑글을 한마디로 소개한다면?"
        }
        
        enum TimePicker {
            enum PickerButton {
                static let doneButton = "Done"
                static let resetButton = "Reset"
            }
        }
    }
    
    enum CTAButton {
        static let buttonTitle = "다음으로"
        static let enterTitle = "입장하기"
    }
    
    enum ToastView {
        static let wrongCode = "잘못된 초대 코드입니다"
    }
}
