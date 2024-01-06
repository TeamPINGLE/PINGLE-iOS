//
//  String+.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/6/24.
//

import Foundation

extension String {
    func convertToKoreanDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "yyyy년 MM월 dd일"
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    func convertToShortTimeFormat() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"

        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "HH:mm"
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
}
