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
    func searchOrganization(queryDTO: SearchOrganizationRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<[SearchOrganizationResponseDTO]>>) -> Void)
    func organizationDetail(teamId: Int, completion: @escaping (NetworkResult<BaseResponse<OrganizationDetailResponseDTO>>) -> Void)
    func enterInviteCode(teamId: Int, bodyDTO: EnterInviteCodeRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<EnterInviteCodeResponseDTO>>) -> Void)
    func postRefreshToken(completion: @escaping (NetworkResult<BaseResponse<TokenRefreshResponseDTO>>) -> Void)
    func checkName(parameterDTO: CheckNameRequestParameterDTO, completion: @escaping (NetworkResult<BaseResponse<CheckNameResponseDTO>>) -> Void)
    func keyword(completion: @escaping (NetworkResult<BaseResponse<[KeywordResponseDTO]>>) -> Void)
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
    func searchOrganization(queryDTO: SearchOrganizationRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<[SearchOrganizationResponseDTO]>>) -> Void) {
        fetchData(target: .searchOrganization(queryDTO),
                  responseData: BaseResponse<[SearchOrganizationResponseDTO]>.self, completion: completion)
    }
    func organizationDetail(teamId: Int, completion: @escaping (NetworkResult<BaseResponse<OrganizationDetailResponseDTO>>) -> Void) {
        fetchData(target: .organizationDetail(teamId),
                  responseData: BaseResponse<OrganizationDetailResponseDTO>.self, completion: completion)
    }
    
    func enterInviteCode(teamId: Int, bodyDTO: EnterInviteCodeRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<EnterInviteCodeResponseDTO>>) -> Void) {
        fetchData(target: .enterInviteCode(teamId, bodyDTO),
                  responseData: BaseResponse<EnterInviteCodeResponseDTO>.self, completion: completion)
    }
    func postRefreshToken(completion: @escaping (NetworkResult<BaseResponse<TokenRefreshResponseDTO>>) -> Void) {
        fetchData(target: .postRefreshToken, responseData: BaseResponse<TokenRefreshResponseDTO>.self, completion: completion)
    }
    func checkName(parameterDTO: CheckNameRequestParameterDTO, completion: @escaping (NetworkResult<BaseResponse<CheckNameResponseDTO>>) -> Void) {
        fetchData(target: .checkName(parameterDTO), responseData: BaseResponse<CheckNameResponseDTO>.self, completion: completion)
    }
    func keyword(completion: @escaping (NetworkResult<BaseResponse<[KeywordResponseDTO]>>) -> Void) {
        fetchData(target: .keyword, responseData: BaseResponse<[KeywordResponseDTO]>.self, completion: completion)
    }
}
