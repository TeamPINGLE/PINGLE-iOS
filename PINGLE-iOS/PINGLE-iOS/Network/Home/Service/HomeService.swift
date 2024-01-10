//
//  HomeService.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/9/24.
//

import Foundation

protocol HomeServiceProtocol {
    func pinList(teamId: Int, completion: @escaping (NetworkResult<BaseResponse<[HomePinListResponseDTO]>>) -> Void)
    func pinDetail(pinId: Int, teamId: Int, completion: @escaping (NetworkResult<BaseResponse<[HomePinDetailResponseDTO]>>) -> Void)
    func meetingJoin(meetingId: Int, completion: @escaping (NetworkResult<BaseResponse<String?>>) -> Void)
    func meetingCancel(meetingId: Int, completion: @escaping (NetworkResult<BaseResponse<String?>>) -> Void)
}

final class HomeService: APIRequestLoader<HomeTarget>, HomeServiceProtocol {
    func pinList(teamId: Int, completion: @escaping (NetworkResult<BaseResponse<[HomePinListResponseDTO]>>) -> Void) {
        fetchData(target: .pinList(teamId),
                  responseData: BaseResponse<[HomePinListResponseDTO]>.self, completion: completion)
    }
    
    func pinDetail(pinId: Int, teamId: Int, completion: @escaping (NetworkResult<BaseResponse<[HomePinDetailResponseDTO]>>) -> Void) {
        fetchData(target: .pinDetail(teamId, pinId),
                  responseData: BaseResponse<[HomePinDetailResponseDTO]>.self, completion: completion)
    }

    
    func meetingJoin(meetingId: Int, completion: @escaping (NetworkResult<BaseResponse<String?>>) -> Void) {
        fetchData(target: .meetingJoin(meetingId),
                  responseData: BaseResponse<String?>.self, completion: completion)
    }

    
    func meetingCancel(meetingId: Int, completion: @escaping (NetworkResult<BaseResponse<String?>>) -> Void) {
        fetchData(target: .meetingCancel(meetingId),
                  responseData: BaseResponse<String?>.self, completion: completion)
    }
}
