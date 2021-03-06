//
//  UILabel+Extension.swift
//  CatchMe
//
//  Created by 양수빈 on 2021/07/09.
//

import UIKit

extension UILabel {
    func addCharacterSpacing(kernValue: Double = -0.6, paragraphValue: CGFloat = 4.0) {
        if let labelText = text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = paragraphValue
            attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
            attributedText = attributedString
            
            if #available(iOS 14.0, *) {
                lineBreakStrategy = .hangulWordPriority
            } else {
                lineBreakMode = .byWordWrapping
            }
        }
    }
    
    func addAddCatchuCharacterSpacing(kernValue: Double = -0.6) {
        if let labelText = text, labelText.count > 0 {
            let attributedStr = NSMutableAttributedString(string: labelText)
            attributedStr.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: attributedStr.length - 1))
            attributedStr.addAttribute(.foregroundColor, value: UIColor.pink210, range: (labelText as NSString).range(of: "캐츄"))
            attributedStr.addAttribute(.font, value: UIFont.stringBoldSystemFont(ofSize: 22), range: (labelText as NSString).range(of: "캐츄"))
            
            attributedText = attributedStr
        }
    }
    
    func addPopupCharacterSpacing(kernValue: Double = -0.1) {
        if let labelText = text, labelText.count > 0 {
            let attributedStr = NSMutableAttributedString(string: labelText)
            attributedStr.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: attributedStr.length - 1))
            attributedStr.addAttribute(.foregroundColor, value: UIColor.pink210, range: (labelText as NSString).range(of: "캐츄 잡기"))
            
            attributedText = attributedStr
        }
    }
}
