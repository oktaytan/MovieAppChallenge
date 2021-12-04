//
//  DetailTopView.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 3.12.2021.
//

import UIKit

final class DetailView: UIView {
    
    var duration = UITextView()
    var release = UITextView()
    var language = UITextView()
    var synopsis = UITextView()
    var director = UITextView()
    var writer = UITextView()
    var actors = UITextView()
    var synopsisDetail = ""
    let movieRating = MovieRating()
    
    let summary = "When a beautiful stranger leads computer hacker Neo to a forbidding underworld, he discovers the shocking trut the life he knows is the elaborate deception of an evil cyber-intelligence."
    
    lazy var moviePoster: UIImageView = {
        let poster = UIImageView()
        let image = UIImage(named: "no_photo")
        poster.image = image
        poster.contentMode = .scaleAspectFill
        poster.layer.cornerRadius = 24
        poster.clipsToBounds = true
        return poster
    }()
    
    lazy var synopsisTitle: UILabel = {
        let label = UILabel()
        label.text = "Synopsis"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .textColor
        return label
    }()
    
    lazy var synopsisText: UITextView = {
        let textView = UITextView()
        
        let attributedText = NSMutableAttributedString(string: synopsisDetail, attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .regular),
            NSAttributedString.Key.foregroundColor: UIColor.subTextColor
        ])
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        let range = NSMakeRange(0, attributedText.string.count)
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
        
        textView.attributedText = attributedText
        textView.isEditable = false
        textView.contentInset = .zero
        textView.textAlignment = .justified
        textView.isScrollEnabled = false
        return textView
    }()
    
    init() {
        super.init(frame: .zero)
//        setupView()
//        setupHierarchy()
//        setupLayout()
    }
    
    lazy var topStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.backgroundColor = .none
        return stack
    }()
    
    lazy var bottomStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .leading
        stack.backgroundColor = .none
        return stack
    }()
    
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
