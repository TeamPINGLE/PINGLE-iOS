//
//  MyPINGLEResponseDTO.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/17/24.
//

import Foundation

struct MyPINGLEResponseDTO: Codable {
    let id: Int
    let category: String
    let name: String
    let ownerName: String
    let location: String
    let dDay: String
    let date: String
    let startAt: String
    let endAt: String
    let maxParticipants: Int
    let curParticipants: Int
    let isOwner: Bool
}

let myPingleDummy: [MyPINGLEResponseDTO] = 
[MyPINGLEResponseDTO(id: 1, category: "PLAY", name: "밥 먹을 사람", ownerName: "정채은", location: "뉴욕", dDay: "D-1", date: "2024-01-17", startAt: "10:00", endAt: "13:10", maxParticipants: 10, curParticipants: 5, isOwner: true),
 MyPINGLEResponseDTO(id: 2, category: "STUDY", name: "하루종일너란바닷속을항해하는나는아쿠아맨헤엄헤엄헤엄", ownerName: "강민수", location: "하얀집", dDay: "D-Day", date: "2024-01-17", startAt: "10:00", endAt: "13:10", maxParticipants: 10, curParticipants: 10, isOwner: false),
 MyPINGLEResponseDTO(id: 3, category: "MULTI", name: "쩔", ownerName: "방민지", location: "위치라고", dDay: "D-2", date: "2024-01-17", startAt: "11:00", endAt: "13:10", maxParticipants: 2, curParticipants: 1, isOwner: false),
 MyPINGLEResponseDTO(id: 4, category: "OTHERS", name: "핑글아", ownerName: "정채은", location: "여의도 더현대", dDay: "D-2", date: "2024-01-17", startAt: "10:00", endAt: "13:10", maxParticipants: 12, curParticipants: 5, isOwner: true),
 MyPINGLEResponseDTO(id: 5, category: "PLAY", name: "파이팅", ownerName: "박소현", location: "뉴욕", dDay: "D-9", date: "2024-01-17", startAt: "15:00", endAt: "21:10", maxParticipants: 99, curParticipants: 99, isOwner: false),
 MyPINGLEResponseDTO(id: 6, category: "MULTI", name: "헷", ownerName: "김승연", location: "뉴욕", dDay: "D-7", date: "2024-01-17", startAt: "17:00", endAt: "20:10", maxParticipants: 99, curParticipants: 1, isOwner: false)]
