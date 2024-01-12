//
//  MeetingService.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 1/12/24.
//

import Foundation

protocol MeetingServiceProtocol {
    func searchPlace(queryDTO: SearchPlaceRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<[SearchPlaceResponseDTO]>>) -> Void)
}

final class MeetingService: APIRequestLoader<MeetingTarget>, MeetingServiceProtocol{
    func searchPlace(queryDTO: SearchPlaceRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<[SearchPlaceResponseDTO]>>) -> Void) {
        fetchData(target: .searchPlace(queryDTO), responseData: BaseResponse<[SearchPlaceResponseDTO]>.self, completion: completion)
    }
}
