//
//  MyPINGLEService.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/18/24.
//

import Foundation

protocol MyPINGLEServiceProtocol {
    func myList(queryDTO: MyPINGLEListRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<[MyPINGLEResponseDTO]>>) -> Void)
}

final class MyPINGLEService: APIRequestLoader<MyPINGLETarget>, MyPINGLEServiceProtocol {
    func myList(queryDTO: MyPINGLEListRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<[MyPINGLEResponseDTO]>>) -> Void) {
        fetchData(target: .myList(queryDTO: queryDTO),
                  responseData: BaseResponse<[MyPINGLEResponseDTO]>.self, completion: completion)
    }
}
