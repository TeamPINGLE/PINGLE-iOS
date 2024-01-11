//
//  SearchPlaceDTO.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 1/12/24.
//

import Foundation

struct SearchPlaceResponseDTO: Codable {
    let x: Double
    let y: Double
    let location: String
    let address: String
    let roadAddress: String
}
