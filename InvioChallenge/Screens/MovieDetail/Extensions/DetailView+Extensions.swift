//
//  DetailView+Extensions.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 3.12.2021.
//

import UIKit

extension DetailView {
    
    func setAttributedText(for text: String?, at subText: String, space: CGFloat = 8.0) -> UITextView {
        let textView = UITextView()
        
        var attributedText: NSMutableAttributedString
        
        if let text = text {
            attributedText = NSMutableAttributedString(string: "\(text)\n", attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .semibold),
                NSAttributedString.Key.foregroundColor: UIColor.textColor
            ])
            
            attributedText.append(NSAttributedString(string: subText, attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular),
                NSAttributedString.Key.foregroundColor: UIColor.subTextColor
            ]))
        } else {
            attributedText = NSMutableAttributedString(string: subText, attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .regular),
                NSAttributedString.Key.foregroundColor: UIColor.subTextColor
            ])
        }
       
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = space
        let range = NSMakeRange(0, attributedText.string.count)
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
        
        textView.attributedText = attributedText
        textView.isEditable = false
        textView.textAlignment = .center
        textView.frame = .init(x: 0, y: 0, width: 80, height: 60)
        textView.backgroundColor = .none
        return textView
    }
    
    func setAttributedTextReverse(for text: String?, at subText: String, space: CGFloat = 8.0) -> UITextView {
        let textView = UITextView()
        
        var attributedText: NSMutableAttributedString
        
        if let text = text {
            attributedText = NSMutableAttributedString(string: "\(text)\n", attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular),
                NSAttributedString.Key.foregroundColor: UIColor.subTextColor
            ])
            
            attributedText.append(NSAttributedString(string: subText, attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .regular),
                NSAttributedString.Key.foregroundColor: UIColor.textColor
            ]))
        } else {
            attributedText = NSMutableAttributedString(string: subText, attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .regular),
                NSAttributedString.Key.foregroundColor: UIColor.textColor
            ])
        }
       
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = space
        let range = NSMakeRange(0, attributedText.string.count)
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
        
        textView.attributedText = attributedText
        textView.isEditable = false
        textView.textAlignment = .left
        textView.frame = .init(x: 0, y: 0, width: 80, height: 60)
        textView.backgroundColor = .none
        return textView
    }
    
}
