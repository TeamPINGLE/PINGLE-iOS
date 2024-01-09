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
}
