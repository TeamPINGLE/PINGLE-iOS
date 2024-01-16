//
//  ImageLiterals.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 12/27/23.
//

import UIKit

enum ImageLiterals {
    
    // 필요한 enum을 만들어서 사용해주세요
    // 사용예시: imageView.image = ImageLiterals.OnBoarding.imgExample
    
    enum Icon {
        static var imgArrowLeft: UIImage { .load(named: "imgArrowLeft").withRenderingMode(.alwaysOriginal)}
        static var imgSearchIcon: UIImage { .load(named: "imgSearchIcon").withRenderingMode(.alwaysOriginal)}
        static var imgCheckDefault: UIImage { .load(named: "imgCheckDefault")}
        static var imgCheckSelected: UIImage { .load(named: "imgCheckSelected")}
        static var imgWarningNotice: UIImage { .load(named: "imgWarningNotice")}
        static var icInfo: UIImage { .load(named: "icInfo")}
        static var icArrowRight: UIImage { .load(named: "icArrowRight")}
    }
    
    enum Work {
        static var imgWorkGraphic: UIImage { .load(named: "imgWorkGraphic")}
    }
    
    enum OnBoarding {
        static var imgPINGLELogo: UIImage { .load(named: "imgPINGLELogo")}
        static var imgApplelogo: UIImage { .load(named: "imgApplelogo")}
        static var imgApplogo: UIImage { .load(named: "imgApplogo")}
        static var imgSearchGraphic: UIImage { .load(named: "imgSearchGraphic")}
        static var imgCreateGraphic: UIImage { .load(named: "imgCreateGraphic")}
        static var imgGraphic1: UIImage { .load(named: "imgGraphic1")}
    }
    
    enum TabBar {
        static var icHome: UIImage { .load(named: "icHome")}
        static var icHomeSelected: UIImage { .load(named: "icHomeSelected")}
        static var icRanking: UIImage { .load(named: "icRanking")}
        static var icRankingSelected: UIImage { .load(named: "icRankingSelected")}
        static var icMeeting: UIImage { .load(named: "icMeeting")}
        static var icMeetingSelected: UIImage { .load(named: "icMeetingSelected")}
        static var icMyPingle: UIImage { .load(named: "icMyPingle")}
        static var icMyPingleSelected: UIImage { .load(named: "icMyPingleSelected")}
        static var icMore: UIImage { .load(named: "icMore")}
        static var icMoreSelected: UIImage { .load(named: "icMoreSelected")}
        static var imgSetting: UIImage { .load(named: "imgSetting")}
    }
    
    enum Home {
        enum Chips {
            static var btnMultiChip: UIImage { .load(named: "btnMultiChip")}
            static var btnMultiChipSelected: UIImage { .load(named: "btnMultiChipSelected")}
            static var btnOtherChip: UIImage { .load(named: "btnOtherChip")}
            static var btnOthersChipSelected: UIImage { .load(named: "btnOthersChipSelected")}
            static var btnPlayChip: UIImage { .load(named: "btnPlayChip")}
            static var btnPlayChipSelected: UIImage { .load(named: "btnPlayChipSelected")}
            static var btnStudyChip: UIImage { .load(named: "btnStudyChip")}
            static var btnStudyChipSelected: UIImage { .load(named: "btnStudyChipSelected")}
        }
        
        enum Map {
            static var icMapHere: UIImage { .load(named: "icMapHere")}
            static var icMapList: UIImage { .load(named: "icMapList")}
            static var icMapMap: UIImage { .load(named: "icMapMap")}
            static var icLocationOverlay: UIImage { .load(named: "icLocationOverlay")}
            static var imgMapPinPlay: UIImage { .load(named: "imgMapPinPlay")}
            static var imgMapPinPlayActive: UIImage { .load(named: "imgMapPinPlayActive")}
            static var imgMapPinStudy: UIImage { .load(named: "imgMapPinStudy")}
            static var imgMapPinStudyActive: UIImage { .load(named: "imgMapPinStudyActive")}
            static var imgMapPinMulti: UIImage { .load(named: "imgMapPinMulti")}
            static var imgMapPinMultiActive: UIImage { .load(named: "imgMapPinMultiActive")}
            static var imgMapPinOther: UIImage { .load(named: "imgMapPinOther")}
            static var imgMapPinOtherActive: UIImage { .load(named: "imgMapPinOtherActive")}
        }
        
        enum Detail {
            static var imgPlayBadge: UIImage { .load(named: "imgPlayBadge")}
            static var imgStudyBadge: UIImage { .load(named: "imgStudyBadge")}
            static var imgMultiBadge: UIImage { .load(named: "imgMultiBadge")}
            static var imgOthersBadge: UIImage { .load(named: "imgOthersBadge")}
            static var icCalendar: UIImage { .load(named: "icCalendar")}
            static var icLocation: UIImage { .load(named: "icLocation")}
            static var icParticipantArrow: UIImage { .load(named: "icParticipantArrow")}
            static var icParticipantArrowActivate: UIImage { .load(named: "icParticipantArrowActivate")}
        }
    }
  
    enum Meeting {
        enum Icon {
            static var icBack: UIImage { .load(named: "icBackButton")}
            static var icCalendar: UIImage { .load(named: "icCalendar")}
            static var icLocation: UIImage { .load(named: "icLoation")}
            static var icUser: UIImage { .load(named: "icUser")}
        }
        
        enum Guide {
            static var imgExitButton: UIImage { .load(named: "imgExitButton")}
            static var imgMeetingGrphic: UIImage { .load(named: "graphicIntro")}
        }
        
        enum Category {
            static var categoryPlayImage: UIImage { .load(named: "graphicPlay")}
            static var categoryStudyImage: UIImage { .load(named: "graphicStudy")}
            static var categoryMultiImage: UIImage { .load(named: "graphicMulti")}
            static var categoryOthersImage: UIImage { .load(named: "graphicOthers")}
            
            enum Badge {
                static var playBadge: UIImage { .load(named: "imgPlayBadge")}
                static var studyBadge: UIImage { .load(named: "imgStudyBadge")}
                static var multiBadge: UIImage { .load(named: "imgMultiBadge")}
                static var othersBadge: UIImage { .load(named: "imgOthersBadge")}
            }
        }
        
        enum ProgressBar {
            static var progressBarImage1: UIImage { .load(named: "imgProgressBar1")}
            static var progressBarImage2: UIImage { .load(named: "imgProgressBar2")}
            static var progressBarImage3: UIImage { .load(named: "imgProgressBar3")}
            static var progressBarImage4: UIImage { .load(named: "imgProgressBar4")}
            static var progressBarImage5: UIImage { .load(named: "imgProgressBar5")}
            static var progressBarImage6: UIImage { .load(named: "imgProgressBar6")}
            static var progressBarImage7: UIImage { .load(named: "imgProgressBar7")}
        }
    }
    
    enum MyPingle {
        enum Icon {
            static var icChat: UIImage { .load(named: "icChat")}
            static var btnMyPingleMore: UIImage { .load(named: "btnMyPingleMore")}
            static var icTrash: UIImage { .load(named: "icTrash")}
            static var icTrashDisabled: UIImage { .load(named: "icTrashDisabled")}
            static var icCalendar: UIImage { .load(named: "icCalendar")}
            static var icLocation: UIImage { .load(named: "icLocation")}
            static var icUser: UIImage { .load(named: "icUser")}
            static var icRightArrow: UIImage { .load(named: "icParticipantArrowActivate")}
        }
    }
}

extension UIImage {
    static func load(named imageName: String) -> UIImage {
        guard let image = UIImage(named: imageName, in: nil, compatibleWith: nil) else {
            return UIImage()
        }
        return image
    }
    
    func resize(to size: CGSize) -> UIImage {
        let image = UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
        return image
    }
}
