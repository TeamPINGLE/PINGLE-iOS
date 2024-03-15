//
//  ProfileService.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/12/24.
//

import Foundation

protocol ProfileServiceProtocol {
    func logout(completion: @escaping (NetworkResult<BaseResponse<String?>>) -> Void)
    func deleteID(completion: @escaping (NetworkResult<BaseResponse<String?>>) -> Void)
    func myTeams(completion: @escaping (NetworkResult<BaseResponse<[MyTeamsResponseDTO]>>) -> Void)
}

final class ProfileService: APIRequestLoader<ProfileTarget>, ProfileServiceProtocol {
    func logout(completion: @escaping (NetworkResult<BaseResponse<String?>>) -> Void) {
        fetchData(target: .logout,
                  responseData: BaseResponse<String?>.self, completion: completion)
    }
    func deleteID(completion: @escaping (NetworkResult<BaseResponse<String?>>) -> Void) {
        fetchData(target: .deleteID,
                  responseData: BaseResponse<String?>.self, completion: completion)
    }
    func myTeams(completion: @escaping (NetworkResult<BaseResponse<[MyTeamsResponseDTO]>>) -> Void) {
        fetchData(target: .myTeams,
                  responseData: BaseResponse<[MyTeamsResponseDTO]>.self, completion: completion)
    }
}
