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
            static let existingOrganization = "이미 등록된\n단체가 있어요"
            static let makeOrganization = "새로운 단체를\n등록하고 싶어요"
            static let requestOrganization = "단체를 직접 추가해주세요"
        }
        
        enum ExplainTitle {
            static let onboarding = "입장 방식을\n선택해주세요!"
            static let searchOrganization = "속해있는 단체의\n이름을 알려주세요!"
            static let bottomRequest = "찾는 단체가 없나요?"
            static let noResult = "검색 결과가 없어요"
            static let inviteCodeTitle = "단체 정보를 확인하고\n초대 코드를 입력해주세요!"
            static let meetingNumber = "개최된 핑글 수"
            static let memberNumber = "참여자 수"
            static let inviteCodeTextFieldTitle = "초대코드"
            static let infoMessage = "단체 개설자로부터 받은 초대 코드를 입력해주세요"
            static let entranceTitle = "모든 준비가\n끝났어요!"
            static let postposition = "에서"
            static let welcomMessage = "핑글 여정을 함께해보세요!"
            static let loginTitle = "Ready to\nPINGLE?"
            static let loginIntroduce = "가볍고 재미있는 모임 문화,"
            static let loginAdvice = "핑글과 함께 만들어요!"
        }
        
        enum NavigationTitle {
            static let searchOrganizationNavigation = "단체 입장하기"
        }
        
        enum SearchBarPlaceholder {
            static let searchOrganizationPlaceholder = "단체 이름을 검색해보세요"
            static let inviteCodePlaceholder = "초대 코드를 입력해주세요"
        }
    }
    
    enum TabBar {
        enum ItemTitle {
            static let home = "홈"
            static let recommend = "랭킹"
            static let addPingle = "개최"
            static let myPingle = "마이핑글"
            static let setting = "더보기"
        }
    }
    
    enum Fix {
        static let fixTitle = "아직 공사중!"
        static let fixDescription = "아직 구현중인 기능이에요\n조금만 기다려주세요"
    }

    enum Home {
        enum Detail {
            static let participantsTitle = "참여현황"
            static let slash = "/"
            static let complete = "모집완료"
            static let dateTimeTitle = "일시"
            static let locationTitle = "장소"
            static let talkButton = "대화하기"
            static let participationButton = "참여하기"
            static let cancelButton = "취소하기"
            static let askDescription = "이 핑글에 참여할까요?"
            static let cancelTitle = "참여를 취소하시겠어요?"
            static let cancelDescription = "취소한 모임은 언제든 다시 신청할 수 있어요"
            static let backButton = "돌아가기"
        }
    }
          
    enum Meeting {
        enum MeetingGuide {
            static let guideTitle = "새로운 핑글을\n개최해보아요!"
            static let guideSubTitle = "어쩌구 번개를 개최하고\n어쩌구 번개를 개최하고"
            static let buttonTitle = "핑글 개최하러 가기"
        }
        
        enum MeetingCategory {
            
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
        
        enum DatePicker {
            enum PickerButton {
                static let doneButton = "Done"
                static let resetButton = "Reset"
            }
        }
        
        enum DateSelection {
            static let dateSelecionTitle = "핑글러들과\n언제 만날까요?"
            static let PINGLEDateTitle = "핑글 날짜"
            static let PINGLEDatePlaceholder = "만날 날짜를 선택해주세요"
            static let PINGLEStartTime = "시작 시각"
            static let PINGLEEndTime = "종료 시각"
            static let PINGLETimePlacsholder = "00:00"
        }
        
        enum ExitModalView {
            static let exitQuestion = "잠깐! 나가실건가요?"
            static let exitWarning = "지금까지 입력한 정보는 전부 사라져요"
            static let continueMaking = "이어서 작성하기"
        }
        
        enum Recruitment {
            static let recruitTitle = "몇 명의 @@들과\n만날까요?"
            static let recruitCondition = "본인을 포함하여,\n최소 1명부터 참여 인원을 선택해주세요"
            static let warningLabel = "최대 선택 가능 인원은 99명이에요!"
        }
      
        enum SearhPlace {
            static let placeholder = "핑글이 열릴 장소 이름을 검색해보세요"
            static let searchPlaceTitle = "함께할 @@들과\n어디서 만날까요?"
            static let noPlaceResult = "검색 결과가 없어요"
            static let reSearch = "다른 장소로 검색해보세요"
        }

        enum OpenChat {
            static let openChatTitle = "오픈채팅방 링크를\n추가해주세요!"
            static let insertChatLinkTitle = "채팅방 링크"
            static let insertChatLinkExplain = "링크를 입력해주세요"
        }
    }
    
    enum Profile {
        enum ExplainTitle {
            static let settingTitle = "설정"
            static let organizationTitle = "나의 단체"
            static let versionTitle = "버전"
            static let versionInfo = "0.0.0"
            static let logoutQuestionTitle = "정말로 로그아웃 하실건가요?"
            static let deleteQuestionTitle = "정말로 탈퇴하실건가요?"
            static let logoutExplanation = "Apple 계정을 로그아웃합니다"
            static let deleteExplanation = "탈퇴 시 계정은 삭제되며 복구할 수 없어요"
        }
        
        enum ButtonTitle {
            static let contactTitle = "문의하기"
            static let noticeTitle = "공지사항"
            static let logoutTitle = "로그아웃"
            static let deleteTitle = "탈퇴하기"
            static let backTitle = "돌아가기"
        }
    }
    
    enum CTAButton {
        static let buttonTitle = "다음으로"
        static let enterTitle = "입장하기"
        static let startTitle = "시작하기"
    }
    
    enum ToastView {
        static let wrongCode = "초대 코드를 다시 확인해주세요!"
    }
}
