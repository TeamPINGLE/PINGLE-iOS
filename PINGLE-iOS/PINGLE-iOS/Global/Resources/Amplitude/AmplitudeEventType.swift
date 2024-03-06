//
//  AmplitudeEventType.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 3/5/24.
//

import Foundation

public enum AmplitudeEventType: String {
    case openApp = "open_app"
    
    case startSignup = "start_signup"
    case completeSignup = "complete_signup"
    case clickMethodOption = "click_method_option"
    case clickExistingGroupCreategroup = "clickExistinggroupCreategroup"
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
}
