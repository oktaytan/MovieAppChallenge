//
//  UIView+Extension.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 2.12.2021.
//

import UIKit

struct AnchorContraints {
    var top: NSLayoutConstraint?
    var bottom: NSLayoutConstraint?
    var leading: NSLayoutConstraint?
    var trailing: NSLayoutConstraint?
    var width: NSLayoutConstraint?
    var height: NSLayoutConstraint?
}


/*
 *
 * Auto Layout için extension
 *
 */
extension UIView {
    
    // Bir view'i başka bir view'e göre ayarlama
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                leading: NSLayoutXAxisAnchor?,
                trailing: NSLayoutXAxisAnchor?,
                padding: UIEdgeInsets = .zero,
                size: CGSize = .zero) -> AnchorContraints {
        
        translatesAutoresizingMaskIntoConstraints = false

        var aConstraints = AnchorContraints()
        
        if let top = top {
            aConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let bottom = bottom {
            aConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let leading = leading {
            aConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let trailing = trailing {
            aConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if size.width != 0 {
            aConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            aConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        [aConstraints.top, aConstraints.bottom, aConstraints.leading, aConstraints.trailing, aConstraints.width, aConstraints.height].forEach { $0?.isActive = true }
        
        return aConstraints
    }
    
    // View'i parent view'in içine doldurur.
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let sTop = superview?.topAnchor {
            topAnchor.constraint(equalTo: sTop, constant: padding.top).isActive = true
        }
        
        if let sBottom = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: sBottom, constant: -padding.bottom).isActive = true
        }
        
        if let sLeading = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: sLeading, constant: padding.left).isActive = true
        }
        
        if let sTrailing = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: sTrailing, constant: -padding.right).isActive = true
        }
        
    }
    
    // Bir view'i başka bir view'in ortasına hizalar
    func centerWithSuperview(size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let centerX = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        
        if let centerY = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
    }
    
    // Bir view'i başka bir view'i X koordinatında ayarlama
    func centerX(_ anchor: NSLayoutXAxisAnchor) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: anchor).isActive = true
    }
    
    // Bir view'i başka bir view'i Y koordinatında ayarlama
    func centerY(_ anchor: NSLayoutYAxisAnchor) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: anchor).isActive = true
    }
    
    // Bir view'i parent view'in X koordinatına göre ayarlama
    func centerXSuperView() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superViewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superViewCenterXAnchor).isActive = true
        }
    }
    
    // Bir view'i parent view'in Y koordinatına göre ayarlama
    func centerYSuperView() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superViewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superViewCenterYAnchor).isActive = true
        }
    }
    
    // Bir view'e yükseklik set eder
    @discardableResult
    func constraintHeight(_ height: CGFloat) -> AnchorContraints {
        
        translatesAutoresizingMaskIntoConstraints = false
        var const = AnchorContraints()
        
        const.height = heightAnchor.constraint(equalToConstant: height)
        const.height?.isActive = true
        return const
    }
    
    // Bir view'e genişlik set eder
    @discardableResult
    func constraintWidth(_ width: CGFloat) -> AnchorContraints {
        
        translatesAutoresizingMaskIntoConstraints = false
        var const = AnchorContraints()
        
        const.width = widthAnchor.constraint(equalToConstant: width)
        const.width?.isActive = true
        return const
    }
    
    // Bir view'e gölge set eder
    func addShadow(opacity: Float = 0, radius: CGFloat = 0, offset: CGSize = .zero, color: UIColor = .black) {
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
    }
    
    func primaryShadow() {
        self.addShadow(opacity: 0.1, radius: 16, offset: .zero, color: .rgb(red: 72, green: 101, blue: 129))
    }
    
    convenience init(backgroundColor: UIColor = .clear) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
    }
    
}
