//
//  LoadingIndicatorView.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 2.12.2021.
//

import UIKit
import NVActivityIndicatorView

final class LoadingIndicatorView: UIStackView {
    
    var isLoading: Bool = false {
        didSet {
            if isLoading {
                self.loadingIndicator.startAnimating()
                self.isHidden = false
            } else {
                self.loadingIndicator.stopAnimating()
                self.isHidden = true
            }
        }
    }
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    lazy var loadingIndicator: NVActivityIndicatorView = {
        let indicator = NVActivityIndicatorView(frame: .init(x: 0, y: 0, width: 60, height: 60), type: NVActivityIndicatorType.triangleSkewSpin, color: .primaryColor, padding: nil)
        return indicator
    }()
    
    lazy var loadingText: UILabel = {
        let label = UILabel()
        label.text = "Loading.."
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .primaryColor
        return label
    }()
    
    fileprivate func setupView() {
        self.axis = .vertical
        self.distribution = .equalSpacing
        self.spacing = 6
        self.addArrangedSubview(loadingIndicator)
        self.addArrangedSubview(loadingText)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
