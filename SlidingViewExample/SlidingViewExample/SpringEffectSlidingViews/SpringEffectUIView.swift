//
//  SpringEffectView.swift
//  Practice
//
//  Created by Himan Dhawan on 23/09/21.
//

import Foundation
import UIKit

class SpringEffectUIView: UIView {
    
    // MARK: - Public Properties
    
    @IBInspectable var backGroundViewColor : UIColor? {
        get {
            return self.backgroundColor
        } set {
            self.backgroundColor = newValue
        }
    }
    
    @IBInspectable var slidingViewColor : UIColor? {
        get {
            return self.slidingView.slidingViewColor
        } set {
            self.slidingView.slidingViewColor = newValue
        }
    }
    
    // MARK: - Private Properties
    
    private var isSlidingViewAdded = false
    private var slidingView : SpringEffectSlidingView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if !isSlidingViewAdded {
            isSlidingViewAdded = true
            slidingView = SpringEffectSlidingView.init(frame: .init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
            self.addSubview(slidingView)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
}

// MARK: - Public functions

extension SpringEffectUIView {
    func slideTo(distance : CGFloat) {
        self.slidingView.showSlider(point: distance)
    }
}
