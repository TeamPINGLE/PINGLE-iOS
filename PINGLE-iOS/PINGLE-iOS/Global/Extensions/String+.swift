//
//  String+.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/6/24.
//

import UIKit

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
    
    func hasCharacters() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[0-9a-zA-Z가-힣ㄱ-ㅎㅏ-ㅣ`~!@#$%^&*()\\-_=+\\[{\\]}\\\\|;:'\",<.>/?\\s]+$", options: .caseInsensitive)
            if let _ = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.count)) {
                return true
            }
        } catch {
            return false
        }
        return false
    }
    
    var isConsonant: Bool {
        guard let scalar = UnicodeScalar(self)?.value else {
            return false
        }
        
        let consonantScalarRange: ClosedRange<UInt32> = 12593...12622
        
        return consonantScalarRange ~= scalar
    }
    
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    func width(withFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
