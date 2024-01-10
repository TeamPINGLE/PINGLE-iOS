//
//  OnboardingService.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/9/24.
//

import Foundation

protocol OnboardingServiceProtocol {
    func login(bodyDTO: LoginRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<LoginResponseDTO>>) -> Void)
    func userInfo(completion: @escaping (NetworkResult<BaseResponse<UserInfoResponseDTO>>) -> Void)
}

final class OnboardingService: APIRequestLoader<OnboardingTarget>, OnboardingServiceProtocol {
    func login(bodyDTO: LoginRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<LoginResponseDTO>>) -> Void) {
        fetchData(target: .login(bodyDTO),
                  responseData: BaseResponse<LoginResponseDTO>.self, completion: completion)
    }
    func userInfo(completion: @escaping (NetworkResult<BaseResponse<UserInfoResponseDTO>>) -> Void) {
        fetchData(target: .userInfo,
                  responseData: BaseResponse<UserInfoResponseDTO>.self, completion: completion)
    }
}