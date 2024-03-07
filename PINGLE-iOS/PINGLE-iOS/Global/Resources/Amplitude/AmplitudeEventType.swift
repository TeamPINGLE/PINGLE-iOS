//
//  AmplitudeEventType.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 3/5/24.
//

import Foundation

public enum AmplitudeEventType: String {
    case openApp = "open_app"
    case closeApp = "close_app"
    case logoutApp = "logout_app"
    case withdrawApp = "withdraw_app"
    case startSignup = "start_signup"
    case completeSignup = "complete_signup"
    case clickMethodOption = "click_method_option"
    case clickExistingGroupCreategroup = "click_existinggroup_creategroup"
    case completeSearchGroup = "complete_search_group"
    case clickExistingGroupEnter = "click_existinggroup_enter"
    case completeExistingGroup = "complete_existinggroup"
    case clickExistingGroupStart = "click_existinggroup_start"
    case completeDoubleCheck = "complete_doublecheck"
    case clickStep1Next = "click_step1_next"
    case clickStep1Info = "click_step1_info"
    case clickStep2Info = "click_step2_info"
    case clickStep3Info = "click_step3_info"
    case clickCreateGroupMake = "click_creategroup_make"
    case completeCreateGroup = "complete_creategroup"
    case clickCreateGroupInvite = "click_creategroup_invite"
    case clickCreateGroupStart = "click_creategroup_start"
    case clickCreateGroupInviteCopy = "click_creategroup_invite_copy"
    case clickCreateGroupInviteShare = "click_creategroup_invite_share"
    case startMyGroup = "start_mygroup"
    case clickInviteCode = "click_invitecode"
    case clickInviteCodeCopy = "click_invitecode_copy"
    case clickInviteCodeShare = "click_invitecode_share"
    case clickOtherGroup = "click_othergroup"
    case clickOtherGroupChange = "click_othergroup_change"
    case clickNewGroup = "click_newgroup"
    case startMeetingHold = "start_meetinghold"
    case clickMeetingCancel = "click_meetingcancel"
    case clickStep1CancelOut = "click_step1_cancel_out"
    case clickStep1CancelStay = "click_step1_cancel_stay"
    case clickStep2CancelOut = "click_step2_cancel_out"
    case clickStep2CancelStay = "click_step2_cancel_stay"
    case clickStep3CancelOut = "click_step3_cancel_out"
    case clickStep3CancelStay = "click_step3_cancel_stay"
    case clickStep4CancelOut = "click_step4_cancel_out"
    case clickStep4CancelStay = "click_step4_cancel_stay"
    case clickStep5CancelOut = "click_step5_cancel_out"
    case clickStep5CancelStay = "click_step5_cancel_stay"
    case clickStep6CancelOut = "click_step6_cancel_out"
    case clickStep6CancelStay = "click_step6_cancel_stay"
    case clickMeetingHold = "click_meetinghold"
    case completeMeetingHold = "complete_meetinghold"
    case scrollRanking = "scroll_ranking"
}
