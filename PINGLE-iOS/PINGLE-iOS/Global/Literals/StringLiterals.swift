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
    
    enum Update {
        static let title = "업데이트 알림"
        static let description = "핑글이 유저분들의 의견을 반영하여 사용성을 개선했습니다. 더 좋아진 핑글 앱을 사용하기 위해서는 새로운 버전으로 업데이트 후 이용해 주세요."
        static let button = "업데이트하기"
    }
    
    enum Onboarding {
        enum ButtonTitle {
            static let appleLogin = "Apple로 시작하기"
            static let existingOrganization = "이미 등록된\n단체가 있어요"
            static let makeOrganization = "새로운 단체를\n등록하고 싶어요"
            static let requestOrganization = "단체를 직접 추가해주세요"
            static let skipButtonTitle = "건너뛰기"
            static let duplicationCheck = "중복 확인"
            static let startHome = "홈으로 시작하기"
        }
        
        enum ExplainTitle {
            static let manualTitle1 = "우리의 모임, PINGLE"
            static let manualSubTitle1 = "원하는 장소에서 사람들과 갖는\n나만의 모임을 뜻해요"
            static let manualTitle2 = "속해있는 단체를 선택하거나\n직접 개설해봐요!"
            static let manualTitle3 = "내 주변에서 열리는 핑글을\n간편하게 찾고 참여해봐요!"
            static let manualTitle4 = "원하는 테마로 간편하게\n핑글을 개최할 수 있어요!"
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
            static let makeOrganizationGuideTitle = "신규 단체 개설 안내"
            static let founderNoticeTitle = "단체 개설자는 탈퇴할 수 없어요"
            static let founderNoticeSubTitle = "해당 단체의 초대코드 및 구성원을\n관리할 책임자가 없어지기 때문이에요."
            static let founderNoticeExpTitle = "탈퇴를 원할 경우, 핑글에게 문의하기를 통해\n개설자를 변경해주셔야 해요."
            static let inviteCodeNoticeTitle = "초대 코드가 유출되었다면\n핑글에게 문의 후\n재발급할 수 있어요"
            static let organizationNameTextFieldTitle = "단체명"
            static let representativeEmailTextFieldTitle = "대표 이메일"
            static let EnterOrganizationInfoTitle = "새로 개설할 단체에\n대해 알려주세요"
            static let emailInfoMessage = "해당 이메일은 초대 코드 공유 및 단체 관리를 위해 사용될 예정입니다"
            static let keyworkSelectTitle = "단체를 설명하는\n키워드를 선택해주세요"
            static let checkOrganizationTitle = "단체 정보를\n확인하세요"
            static let makeCompletedTitle = "단체가\n개설되었어요!"
            static let makeCompletedPostPosition = "에 친구들을 초대하고"
            static let shareInviteCodeTitle = "초대 코드를\n확인하세요"
            static let shareInviteCodeInfoMessage = "초대코드는 더보기 > 나의 단체 페이지에서 다시 확인할 수 있어요"
        }
        
        enum NavigationTitle {
            static let searchOrganizationNavigation = "단체 입장하기"
            static let makeOrganizationNavigation = "신규 단체 개설하기"
            static let shareInviteCodeNavigation = "친구 초대하기"
            static let myOrganizationViewController = "나의 단체"
        }
        
        enum SearchBarPlaceholder {
            static let searchOrganizationPlaceholder = "단체 이름을 검색해보세요"
            static let inviteCodePlaceholder = "초대 코드를 입력해주세요"
            static let organizationNamePlaceholder = "단체명을 입력해주세요"
            static let representativeEmailPlaceholder = "ex. 단체 공식 이메일, 개설자님의 이메일"
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
    
    enum Recommend {
        static let rankingTitle = "랭킹"
        static let nonRanking = "우리 단체에서 핑글이 30회 이상 이루어지면\n랭킹을 확인할 수 있어요!"
        static let latestVisit = "최근방문"
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
            static let deleteButton = "삭제하기"
            static let askDescription = "이 핑글에 참여할까요?"
            static let cancelTitle = "참여를 취소하시겠어요?"
            static let cancelDescription = "취소한 모임은 언제든 다시 신청할 수 있어요"
            static let backButton = "돌아가기"
        }
        
        enum Participants {
            static let participationTitle = "참여현황"
            static let meetingOwner = "개최자"
        }
        
        enum List {
            static let sortRecent = "최신등록순"
            static let sortImminent = "날짜임박순"
            static let emptyList = "현재 개최된 핑글이 없어요.\n핑글을 직접 개최해보세요!"
        }
        
        enum Search {
            static let searchMapExplain = "원하는 핑글을 지도에서 찾아보세요!"
            static let searchListExplain = "원하는 핑글을 리스트에서 찾아보세요!"
            static let searchMapPlaceHolder = "장소 이름 검색"
            static let searchListPlaceHolder = "핑글 이름, 장소 이름 검색"
            static let searchEmptyLabel = "검색 결과가 없어요"
        }
    }
    
    enum Meeting {
        enum MeetingGuide {
            static let guideTitle = "What is\nPINGLE?"
            static let guideSubTitle = "PIN과 MINGLE의 합성어로,\n원하는 장소에서 사람들과 갖는 모임을 뜻해요"
            static let buttonTitle = "핑글 개최하러 가기"
        }
        
        enum MeetingCategory {
            
            enum CategoryLabel {
                static let categoryTitleLabel = "개최할 핑글을\n선택해주세요!"
            }
            
            enum CategoryTitle {
                static let play = "PLAY"
                static let study = "STUDY"
                static let multi = "MULTI"
                static let others = "OTHERS"
            }
            
            enum ExplainCategory {
                static let playExplain = "노는게 제일 좋아!"
                static let studyExplain = "열공, 열작업할 사람 모여라!"
                static let multiExplain = "놀 땐 놀고, 일할 땐 일하자!"
                static let othersExplain = "다른 활동이 하고싶다면?"
            }
            
            enum ExitButton {
                static let exitButton = "나가기"
                static let exitLabel = "나중에 만드시겠어요?"
            }
        }
        
        enum MeetingIntroduction {
            static let introductionTitle = "개최할 핑글을\n소개해주세요!"
            static let PINGLETitle = "한줄 소개"
            static let PINGLEExplain = "ex. 강남역에서 각잡고 공부할 사람?"
        }
        
        enum DatePicker {
            enum PickerButton {
                static let doneButton = "Done"
                static let resetButton = "Reset"
            }
        }
        
        enum DateSelection {
            static let dateSelecionTitle = "함께할 친구들과\n언제 만날까요?"
            static let PINGLEDateTitle = "핑글 날짜"
            static let PINGLEDatePlaceholder = "만날 날짜를 선택해주세요"
            static let PINGLEStartTime = "시작 시각"
            static let PINGLEEndTime = "종료 시각"
            static let PINGLETimePlacsholder = "00:00"
            static let warningMessage = "종료 시각은 시작 시각 이후로 선택해주세요!"
        }
        
        enum ExitModalView {
            static let exitQuestion = "잠깐! 나가실건가요?"
            static let exitWarning = "지금까지 입력한 정보는 전부 사라져요"
            static let continueMaking = "이어서 작성하기"
        }
        
        enum Recruitment {
            static let recruitTitle = "몇 명의 친구들과\n만날까요?"
            static let recruitCondition = "본인을 포함하여,\n최소 1명부터 참여 인원을 선택해주세요"
        }
        
        enum SearhPlace {
            static let placeholder = "핑글이 열릴 장소 이름을 검색해보세요"
            static let searchPlaceTitle = "함께할 친구들과\n어디서 만날까요?"
            static let noPlaceResult = "검색 결과가 없어요"
            static let reSearch = "다른 장소로 검색해보세요"
        }
        
        enum OpenChat {
            static let openChatTitle = "오픈채팅방 링크를\n추가해주세요!"
            static let insertChatLinkTitle = "채팅방 링크"
            static let insertChatLinkExplain = "링크를 입력해주세요"
        }
        
        enum FinalResult {
            static let finalResultTitle = "핑글을 개최할\n준비 되었나요?"
            static let finalResultButton = "핑글 개최하기"
            enum FinalResultCard {
                static let finalCardCalendar = "일시"
                static let fincalCardPlace = "장소"
                static let finalCardRecruitNumber = "모집인원"
            }
        }
    }
    
    enum MyPingle {
        enum Title {
            static let myPingleTitle = "마이핑글"
        }
        
        enum SegmentControl {
            static let soon = "예정된"
            static let complete = "참여완료"
        }
        
        enum List {
            static let soonEmpty = "홈으로 이동해\n내 주변 핑글을 찾아보세요!"
            static let completeEmpty = "아직 예정된 핑글이 없어요\n첫 핑글에 참여해보세요!"
            static let talk = "대화하기"
            static let cancel = "참여 취소하기"
            static let delete = "핑글 삭제하기"
            static let popUpTitle = "참여를 취소하시겠어요?"
            static let popUpDescription = "취소한 모임은 언제든 다시 신청할 수 있어요"
            static let cancelButton = "취소하기"
            static let backButton = "돌아가기"
            static let done = "Done"
        }
        
        enum Delete {
            static let deleteTitle = "핑글을 삭제하시겠어요?"
            static let deleteDescription = "삭제된 핑글은 다시 되돌릴 수 없어요"
            static let deleteButton = "삭제하기"
        }
    }
    
    enum Profile {
        enum ExplainTitle {
            static let settingTitle = "더보기"
            static let organizationTitle = "나의 단체"
            static let versionTitle = "버전"
            static let logoutQuestionTitle = "정말로 로그아웃 하실건가요?"
            static let deleteQuestionTitle = "정말로 탈퇴하실건가요?"
            static let logoutExplanation = "Apple 계정을 로그아웃합니다"
            static let deleteExplanation = "탈퇴 시 계정은 삭제되며 복구할 수 없어요"
            static let meetingNumber = "개최된 핑글 수"
            static let memberNumber = "참여자 수"
            static let shareCodeTitle = "공유하고 더 많은 친구와 함께해보세요!"
            static let questionChangeOrganization = "(으)로\n단체를 변경하시겠어요?"
        }
        
        enum ButtonTitle {
            static let contactTitle = "문의하기"
            static let noticeTitle = "공지사항"
            static let logoutTitle = "로그아웃"
            static let deleteTitle = "탈퇴하기"
            static let backTitle = "돌아가기"
            static let lookInviteCode = "초대코드 보기"
            static let makeOrganization = "새로운 단체 추가하러 가기"
            static let changeTitle = "변경하기"
            static let copyInviteCode = "초대코드 복사하기"
            static let shareTitle = "공유하기"
        }
    }
    
    enum CTAButton {
        static let buttonTitle = "다음으로"
        static let enterTitle = "입장하기"
        static let startTitle = "시작하기"
        static let makeTitle = "개설하기"
        static let inviteFriendTitle = "친구 초대하러 가기"
        static let shareTitle = "공유하기"
    }
    
    enum ToastView {
        static let wrongCode = "초대 코드를 다시 확인해주세요!"
        static let rejectDelete = "단체 개설자는 탈퇴할 수 없어요!"
        static let possibleGroup = "등록 가능한 단체명입니다."
        static let impossibleGroup = "같은 이름을 가진 단체가 이미 존재합니다!"
        static let impossibleEmail = "유효하지 않은 이메일입니다!"
        static let alreadyMeeting = "모집이 마감된 핑글이에요!"
        static let deleteMeeting = "삭제된 핑글이에요!"
        static let completedCopy = "초대코드가 복사되었습니다!"
        static let changeOrganization = "단체가 변경되었습니다!"
        static let alreadySigned = "이미 가입된 단체입니다!"
    }
    
    enum ErrorMessage {
        static let notFoundMeeting = "존재하지 않는 번개입니다"
        static let notFoundMember = "존재하지 않는 유저미팅입니다."
    }
}
