//
//  RankingService.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 2/24/24.
//

import Foundation
 
protocol RankingServiceProtocol {
    func ranking(teamId: Int, completion: @escaping
    (NetworkResult<BaseResponse<RankingResponseDTO>>) -> Void)
}

final class RankingService:
    APIRequestLoader<RankingTarget>, RankingServiceProtocol {
    func ranking(teamId: Int, completion: @escaping (NetworkResult<BaseResponse<RankingResponseDTO>>) -> Void) {
        fetchData(target: .ranking(teamId), responseData: BaseResponse<RankingResponseDTO>.self, completion: completion)
    }
}
