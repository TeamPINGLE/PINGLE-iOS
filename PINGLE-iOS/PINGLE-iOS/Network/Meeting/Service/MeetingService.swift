//
//  MeetingService.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 1/12/24.
//

import Foundation

protocol MeetingServiceProtocol {
    func makeMeeting(bodyDTO: MakeMeetingRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<String?>>) -> Void)
    func searchPlace(queryDTO: SearchPlaceRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<[SearchPlaceResponseDTO]>>) -> Void)
}

final class MeetingService: APIRequestLoader<MeetingTarget>, MeetingServiceProtocol {
    func makeMeeting(bodyDTO: MakeMeetingRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<String?>>) -> Void) {
        let headers = "\(KeychainHandler.shared.userGroup[0].id)"
        fetchData(target: .makeMeeting(bodyDTO), responseData: BaseResponse<String?>.self, completion: completion)
    }
    
    func searchPlace(queryDTO: SearchPlaceRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<[SearchPlaceResponseDTO]>>) -> Void) {
        fetchData(target: .searchPlace(queryDTO), responseData: BaseResponse<[SearchPlaceResponseDTO]>.self, completion: completion)
    }
}

