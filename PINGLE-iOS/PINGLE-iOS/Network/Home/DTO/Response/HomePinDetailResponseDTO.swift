//
//  HomePinDetailResponseDTO.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/6/24.
//

import Foundation

struct HomePinDetailResponseDTO: Codable {
    let id: Int
    let category: String
    let name: String
    let ownerName: String
    let location: String
    let date: String
    let startAt: String
    let endAt: String
    let maxParticipants: Int
    let curParticipants: Int
    let isParticipating: Bool
    let chatLink: String
}

let homePinDetailDummy: [HomePinDetailResponseDTO] =
[HomePinDetailResponseDTO(id: 1, category: "PLAY", name: "하루종일너란바닷속을항해하는나는아쿠아맨헤엄헤엄헤엄",
                          ownerName: "정채은", location: "우리집ㅋ",
                          date: "2024-01-06",
                          startAt: "12:00:00", endAt: "15:30:00",
                          maxParticipants: 99, curParticipants: 99,
                          isParticipating: true, chatLink: "https://www.google.com")]
