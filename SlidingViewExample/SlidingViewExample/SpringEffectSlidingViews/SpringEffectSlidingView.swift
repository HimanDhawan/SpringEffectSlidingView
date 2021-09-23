//
//  SpringEffectView.swift
//  AthleteMinder
//
//  Created by Himan Dhawan on 18/09/21.
//

import UIKit


class SpringEffectSlidingView: UIView {
    
    /// Public variable
    var topPadding : CGFloat {
        return buttonHeight/2 + topPaddingFromButton
    }
    
    var slidingViewColor : UIColor? = UIColor.red
    
    
    
    /// Private variables and init methods
    private var screenWidth : CGFloat! {
        return self.superview?.frame.size.width
    }
    
    private var screenHeight : CGFloat! {
        return self.superview?.frame.size.height
    }
    
    private var screenHeightkey : CGFloat! {
        return UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.frame.size.height
    }
    
    private let buttonHeight : CGFloat = 300
    private var topPaddingFromButton : CGFloat {
        return 0
    }
    private let NonVisibleButtonHeight : CGFloat = 2000
    private let originalButtonHeight : CGFloat = 2000

    private var backGroundView : UIView!
    private var helperSideView : UIView!
    private var helperCenterView : UIView!
    private var difference : CGFloat = 0
    private var displayLink : CADisplayLink!
    private var animationCount : Int = 0
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
}

/// Set up helper views and self frame

extension SpringEffectSlidingView {
    
    private func setup() {
        
        self.helperSideView = UIView.init(frame: .init(x: 0, y: -40, width: 40, height: 40))
        helperSideView.isHidden = true
        self.helperCenterView = UIView.init(frame: .init(x: screenWidth/2-20, y: -40, width: 40, height: 40))
        self.backGroundView = UIView.init(frame: .init(x: screenWidth/2-20, y: -40, width: 40, height: 40))
        helperCenterView.isHidden = true
        self.backGroundView = UIView.init()
        self.backGroundView.frame = superview!.frame
        
        self.backgroundColor = UIColor.clear
        self.frame = CGRect.init(x: 0, y: screenHeight - 200, width: screenWidth, height: originalButtonHeight)
        self.superview?.addSubview(self.helperSideView)
        self.superview?.addSubview(self.helperCenterView)
        
        self.clipsToBounds = true
        self.superview?.clipsToBounds = true
        
    }
}

/// Draw curved bezier path. The curve occurs when "diff" changes. Diff changes in display link function.

extension SpringEffectSlidingView {
    override func draw(_ rect: CGRect) {
        let bezierPath = UIBezierPath.init()
        bezierPath.move(to: .init(x: 0, y: buttonHeight + topPaddingFromButton))
        bezierPath.addLine(to: .init(x: 0, y: buttonHeight/2 + topPaddingFromButton))
        bezierPath.addQuadCurve(to: .init(x: screenWidth, y: buttonHeight/2 + topPaddingFromButton), controlPoint: .init(x: screenWidth/2, y: (buttonHeight/2 + topPaddingFromButton + difference)))
        bezierPath.addLine(to: .init(x: screenWidth, y: NonVisibleButtonHeight))
        bezierPath.addLine(to: .init(x: 0 , y: NonVisibleButtonHeight))
        bezierPath.close()

        
        let context = UIGraphicsGetCurrentContext()!
        context.beginPath()
        context.move(to: .init(x: 0, y: buttonHeight + topPaddingFromButton))
        context.addLine(to: .init(x: 0, y: buttonHeight/2 + topPaddingFromButton))
        context.addQuadCurve(to: .init(x: screenWidth, y: buttonHeight/2 + topPaddingFromButton), control: .init(x: screenWidth/2, y: (buttonHeight/2 + topPaddingFromButton + difference)))
        context.addLine(to: .init(x: screenWidth, y: NonVisibleButtonHeight))
        context.addLine(to: .init(x: 0 , y: NonVisibleButtonHeight))
        context.closePath()
        context.setStrokeColor(UIColor.clear.cgColor)
        context.setFillColor(slidingViewColor?.cgColor ?? UIColor.red.cgColor)
        context.drawPath(using: .fill)
    }
}

/// Used display link to get callbacks when frame changes.

extension SpringEffectSlidingView {
    @objc func displayAction(link : CADisplayLink) {
        let sideHelperPresentationLayer : CALayer = self.helperSideView.layer.presentation()!
        let centerHelperPresentationLayer : CALayer = self.helperCenterView.layer.presentation()!
        
        let centerRect = centerHelperPresentationLayer.value(forKey: "frame") as! CGRect
        let sideRect = sideHelperPresentationLayer.value(forKey: "frame") as! CGRect
        self.difference = sideRect.origin.y - centerRect.origin.y;
        self.setNeedsDisplay()
    }
    
    func beforeAnimation() {
        self.displayLink = CADisplayLink.init(target: self, selector: #selector(displayAction(link:)))
        self.displayLink.add(to: .main, forMode: .default)
        self.animationCount += animationCount
    }
    
    func finishAnimation() {
        self.animationCount -= animationCount
        
        if animationCount == 0 {
            if self.displayLink != nil {
                self.displayLink.invalidate()
                self.displayLink = nil
            }
        }
        
    }
}



/// Public method to show slider movement.

extension SpringEffectSlidingView {
    
    func showSlider(point : CGFloat) {
        self.superview?.insertSubview(self.backGroundView, belowSubview: self)
        UIView.animate(withDuration: 0.3) {
            self.backGroundView.alpha = 0.7
            self.frame = .init(x: 0, y: point - self.buttonHeight/2, width: self.screenWidth, height: self.originalButtonHeight)
        } completion: { _ in
            
        }
        
        self.beforeAnimation()
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.6, options: .beginFromCurrentState) {
            self.helperSideView.center = .init(x: 20, y: point)
        } completion: { _ in
            self.finishAnimation()
        }
        
        self.beforeAnimation()
        
        UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2, options: .beginFromCurrentState) {
            self.helperCenterView.center = .init(x: self.superview!.center.x, y: point)
        } completion: { _ in
            self.finishAnimation()
        }

        

    }

}
