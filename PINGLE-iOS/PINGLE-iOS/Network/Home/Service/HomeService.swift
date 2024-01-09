//
//  HomeService.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/9/24.
//

import Foundation

protocol HomeServiceProtocol {
    func pinList(teamId: String, completion: @escaping (NetworkResult<BaseResponse<[HomePinListResponseDTO]>>) -> Void)
}

final class HomeService: APIRequestLoader<HomeTarget>, HomeServiceProtocol {
    func pinList(teamId: String, completion: @escaping (NetworkResult<BaseResponse<[HomePinListResponseDTO]>>) -> Void) {
        fetchData(target: .pinList(teamId),
                  responseData: BaseResponse<[HomePinListResponseDTO]>.self, completion: completion)
    }
}
