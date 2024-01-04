//
//  HomePinListResponseDTO.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/4/24.
//

import Foundation

struct HomePinListResponseDTO: Codable {
    let id: Int
    let x: String
    let y: String
    let category: String
    let meetingCount: Int
}

let homePinListDummy: [HomePinListResponseDTO] =
[HomePinListResponseDTO(id: 1, x: "37.56299678698725", y: "126.8469346126135", category: "PLAY", meetingCount: 1),
 HomePinListResponseDTO(id: 2, x: "37.57299678698725", y: "126.8569346126135", category: "PLAY", meetingCount: 1),
 HomePinListResponseDTO(id: 3, x: "37.58299678698725", y: "126.8669346126135", category: "STUDY", meetingCount: 1),
 HomePinListResponseDTO(id: 4, x: "37.59299678698725", y: "126.8769346126135", category: "MULTI", meetingCount: 1),
 HomePinListResponseDTO(id: 5, x: "37.60299678698725", y: "126.8669346126135", category: "STUDY", meetingCount: 1),
 HomePinListResponseDTO(id: 6, x: "37.61299678698725", y: "126.8369346126135", category: "OTHERS", meetingCount: 1),
 HomePinListResponseDTO(id: 7, x: "37.62299678698725", y: "126.8469346126135", category: "OTHERS", meetingCount: 1),
 HomePinListResponseDTO(id: 8, x: "37.63299678698725", y: "126.8769346126135", category: "MULTI", meetingCount: 1)]
