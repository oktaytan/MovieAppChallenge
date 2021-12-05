//
//  SynopsisCell.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 4.12.2021.
//

import UIKit

// Filmin konusunu gösterecek view
final class SynopsisCell: BaseCell {
    
    static let id = "SynopsisCell"
    
    var summary: String? {
        didSet {
            guard let synopsis = summary else { return }
            let attributedText = NSMutableAttributedString(string: synopsis, attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .regular),
                NSAttributedString.Key.foregroundColor: UIColor.subTextColor
            ])
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            let range = NSMakeRange(0, attributedText.string.count)
            attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
            
            synopsisText.attributedText = attributedText
        }
    }
    
    lazy var synopsisTitle: UILabel = {
        let label = UILabel()
        label.text = "Synopsis"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .textColor
        return label
    }()
    
    lazy var synopsisText: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.contentInset = .zero
        textView.textAlignment = .justified
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        return textView
    }()
    
    override func setupViews() {
        self.addSubview(synopsisTitle)
        self.addSubview(synopsisText)
        
        synopsisTitle.anchor(top: topAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 24, bottom: 0, right: 24))
        synopsisText.anchor(top: synopsisTitle.bottomAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 20, bottom: 0, right: 24))
    }
    
}
