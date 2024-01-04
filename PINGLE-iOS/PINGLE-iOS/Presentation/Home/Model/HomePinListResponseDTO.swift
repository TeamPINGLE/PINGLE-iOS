//
//  HomePinListResponseDTO.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/4/24.
//

import Foundation

// 추후 DTO 파일로 옮길 예정
struct HomePinListResponseDTO: Codable {
    let id: Int
    let x: String
    let y: String
    let category: String
    let meetingCount: Int
}

let homePinListDummy: [HomePinListResponseDTO] =
[HomePinListResponseDTO(id: 1, x: "37.54031604437719", y: "126.96955038432356", category: "PLAY", meetingCount: 1),
 HomePinListResponseDTO(id: 2, x: "37.55031604437719", y: "126.96785038432356", category: "PLAY", meetingCount: 1),
 HomePinListResponseDTO(id: 3, x: "37.52031604437719", y: "126.9685038432356", category: "STUDY", meetingCount: 1),
 HomePinListResponseDTO(id: 4, x: "37.54031604437719", y: "126.86985038432356", category: "MULTI", meetingCount: 1),
 HomePinListResponseDTO(id: 5, x: "37.55299678698725", y: "126.8698503843235", category: "STUDY", meetingCount: 1),
 HomePinListResponseDTO(id: 6, x: "37.53299678698725", y: "126.8698503843235", category: "OTHERS", meetingCount: 1),
 HomePinListResponseDTO(id: 7, x: "37.51299678698725", y: "126.8698503843235", category: "OTHERS", meetingCount: 1),
 HomePinListResponseDTO(id: 8, x: "37.54031604437719", y: "126.8769346126135", category: "MULTI", meetingCount: 1)]
