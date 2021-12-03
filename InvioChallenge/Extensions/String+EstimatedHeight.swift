//
//  String+EstimatedHeight.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 3.12.2021.
//

import UIKit

extension String {
    
    func estimatedHeightForText(view: UIView) -> CGFloat {
        
        let widthTextView = view.frame.width - 100
        let size = CGSize(width: widthTextView, height: 1000)
        let attributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)]
        let estimatedFrame = NSString(string: self).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        return estimatedFrame.height + 15
        
    }
    
}
