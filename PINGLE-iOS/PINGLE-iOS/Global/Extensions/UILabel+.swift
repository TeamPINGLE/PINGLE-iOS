//
//  UILabel+.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 12/31/23.
//

import UIKit

extension UILabel {
    func asColor(targetString: String, color: UIColor?) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        attributedString.addAttributes([.font: font as Any, .foregroundColor: color as Any], range: range)
        attributedText = attributedString
    }
    
    func asUnderLine(_ targetString: String?) {
        guard let targetString else { return }
        let attributedString = NSAttributedString(string: targetString,
                                                  attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        attributedText = attributedString
    }
    
    func setLineSpacing(spacing: CGFloat) {
        guard let text = text else { return }
        
        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        attributeString.addAttribute(.paragraphStyle,
                                     value: style,
                                     range: NSRange(location: 0, length: attributeString.length))
        attributedText = attributeString
    }
    
    func setLineSpacing(percentage: Double) {
        let spacing = (self.font.pointSize * CGFloat(percentage/100) - self.font.pointSize)/2
        guard let text = text else { return }
        
        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        attributeString.addAttribute(.paragraphStyle,
                                     value: style,
                                     range: NSRange(location: 0, length: attributeString.length))
        attributedText = attributeString
    }
    
    func setAttributeLabel(targetString: [String], color: UIColor?, font: UIFont?, spacing: CGFloat = 0, baseLineOffset: CGFloat = 0) {
        let fullText = text ?? ""
        let style = NSMutableParagraphStyle()
        let attributedString = NSMutableAttributedString(string: fullText)
        
        for target in targetString {
            let range = (fullText as NSString).range(of: target)
            attributedString.addAttributes(
                [.font: font as Any,
                 .foregroundColor: color as Any,
                 .baselineOffset: baseLineOffset], // Add baseline offset here
                range: range
            )
        }
        
        style.lineSpacing = spacing
        attributedString.addAttribute(.paragraphStyle,
                                      value: style,
                                      range: NSRange(location: 0, length: attributedString.length))
        attributedText = attributedString
    }
    
    public func setKerning(withKerning kerning: Double) {
        guard let text = text else { return }
        
        self.attributedText = NSAttributedString(string: text, attributes: [NSAttributedString.Key.kern: kerning])
    }
    
    func setKerning(withPercentage value: Double) {
        let kerning = self.font.pointSize * CGFloat(value/100)
        guard let text = text, !text.isEmpty else { return }
        self.attributedText = NSAttributedString(string: text, attributes: [NSAttributedString.Key.kern: kerning])
    }
    
    func setLineSpacingAndKerning(spacingPercentage: Double, kerningPercentage: Double) {
        let kerning = self.font.pointSize * CGFloat(kerningPercentage/100)
        let spacing = (self.font.pointSize * CGFloat(spacingPercentage/100) - self.font.pointSize)/2
        guard let text = text, !text.isEmpty else { return }
        
        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        attributeString.addAttribute(
            .paragraphStyle,
            value: style,
            range: NSRange(location: 0, length: attributeString.length)
        )
        
        attributeString.addAttribute(
            .kern,
            value: kerning,
            range: NSRange(location: 0, length: attributeString.length - 1))
        
        attributedText = attributeString
    }
}
