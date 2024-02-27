//
//  HomeService.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/9/24.
//

import Foundation

protocol HomeServiceProtocol {
    func pinList(teamId: Int, queryDTO: HomePinListRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<[HomePinListResponseDTO]>>) -> Void)
    func pinDetail(pinId: Int, teamId: Int, queryDTO: HomePinListRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<[HomePinDetailResponseDTO]>>) -> Void)
    func meetingJoin(meetingId: Int, completion: @escaping (NetworkResult<BaseResponse<String?>>) -> Void)
    func meetingCancel(meetingId: Int, completion: @escaping (NetworkResult<BaseResponse<String?>>) -> Void)
    func participantsList(meetingId: Int, completion: @escaping (NetworkResult<BaseResponse<ParticipantsListResponseDTO>>) -> Void)
    func meetingDelete(meetingId: Int, completion: @escaping (NetworkResult<BaseResponse<String?>>) -> Void)
    func listGet(queryDTO: HomeListSearchRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<HomeListSearchResponseDTO>>) -> Void)
}

final class HomeService: APIRequestLoader<HomeTarget>, HomeServiceProtocol {
    func pinList(teamId: Int, queryDTO: HomePinListRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<[HomePinListResponseDTO]>>) -> Void) {
        fetchData(target: .pinList(teamId, queryDTO: queryDTO),
                  responseData: BaseResponse<[HomePinListResponseDTO]>.self, completion: completion)
    }
    
    func pinDetail(pinId: Int, teamId: Int, queryDTO: HomePinListRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<[HomePinDetailResponseDTO]>>) -> Void) {
        fetchData(target: .pinDetail(teamId, pinId, queryDTO: queryDTO),
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
    
    func participantsList(meetingId: Int, completion: @escaping (NetworkResult<BaseResponse<ParticipantsListResponseDTO>>) -> Void) {
        fetchData(target: .participantsList(meetingId),
                  responseData: BaseResponse<ParticipantsListResponseDTO>.self, completion: completion)
    }

    func meetingDelete(meetingId: Int, completion: @escaping (NetworkResult<BaseResponse<String?>>) -> Void) {
        fetchData(target: .meetingDelete(meetingId),
                  responseData: BaseResponse<String?>.self, completion: completion)
    }
    
    func listGet(queryDTO: HomeListSearchRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<HomeListSearchResponseDTO>>) -> Void) {
        fetchData(target: .listGet(queryDTO),
                  responseData: BaseResponse<HomeListSearchResponseDTO>.self, completion: completion)
    }
}

