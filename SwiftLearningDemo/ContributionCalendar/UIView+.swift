//
//  UIView+.swift
//  SwiftLearningDemo
//
//  Created by 三九四九石景山 on 2023/8/17.
//

import Foundation

extension UIView {
    private static let kRotationAnimationKey = "kRotationAnimationKey"
    private static let kScaleAnimationKey = "kScaleAnimationKey"
    
    func popup() {
        alpha = 0
        transform = CGAffineTransformMakeScale(0.3, 3)
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.3) {
            self.alpha = 1
            self.transform = .identity
        }
    }

    func rotate(duration: Double = 1) {
        if layer.animation(forKey: UIView.kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.y")

            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float.pi * 2.0
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = 1

            layer.add(rotationAnimation, forKey: UIView.kRotationAnimationKey)
        }
    }

    func stopRotating() {
        if layer.animation(forKey: UIView.kRotationAnimationKey) != nil {
            layer.removeAnimation(forKey: UIView.kRotationAnimationKey)
        }
    }
    
    func scale(duration: Double = 0.5, revert: Bool = false) {
        if layer.animation(forKey: UIView.kScaleAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.scale")
            
            let smallValue = NSValue(cgSize: CGSize(width: 0, height: 0))
            let biggerValue = NSValue(cgSize: CGSize(width: 1, height: 1))
            
            rotationAnimation.fromValue = revert ? biggerValue : smallValue
            rotationAnimation.toValue = revert ? smallValue : biggerValue
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = 1

            layer.add(rotationAnimation, forKey: UIView.kScaleAnimationKey)
        }
    }
}
