//
//  NetworkService.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/9/24.
//

import Foundation

final class NetworkService {
    static let shared = NetworkService()

    private init() {}

    let onboardingService: OnboardingServiceProtocol = OnboardingService(apiLogger: APIEventLogger())
    let homeService: HomeServiceProtocol = HomeService(apiLogger: APIEventLogger())
//    let recommendService: RecommendServiceProtocol = RecommendService(apiLogger: APIEventLogger())
    let meetingService: MeetingServiceProtocol = MeetingService(apiLogger: APIEventLogger())
    let myPingleService: MyPINGLEServiceProtocol = MyPINGLEService(apiLogger: APIEventLogger())
    let profileService: ProfileServiceProtocol = ProfileService(apiLogger: APIEventLogger())
}
