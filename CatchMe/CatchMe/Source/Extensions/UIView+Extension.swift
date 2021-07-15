//
//  UIView+Extension.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/02.
//

import UIKit

extension UIView {
    func makeShadow(_ color: UIColor, _ opacity: Float, _ offset: CGSize, _ radius: CGFloat) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
    }
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
    
    func fadeIn(duration: TimeInterval = 0.4,
                delay: TimeInterval = 0.0,
                completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: .curveEaseIn,
                       animations: {
                        self.alpha = 1.0
                       }, completion: completion)
    }

    func fadeOut(duration: TimeInterval = 0.2,
                 delay: TimeInterval = 0.0,
                 completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: .curveEaseIn,
                       animations: {
                        self.alpha = 0.0
                       }, completion: completion)
    }
    
    func setCharacterImage(level: Int, index: Int, size: Int) -> UIImage? {
        switch index {
        case Character.green.rawValue:
            return Character.green.getCharacterImage(phase: level, size: size)
        case Character.yellowGreen.rawValue:
            return Character.yellowGreen.getCharacterImage(phase: level, size: size)
        case Character.orange.rawValue:
            return Character.orange.getCharacterImage(phase: level, size: size)
        case Character.blue.rawValue:
            return Character.blue.getCharacterImage(phase: level, size: size)
        case Character.purple.rawValue:
            return Character.purple.getCharacterImage(phase: level, size: size)
        case Character.skyblue.rawValue:
            return Character.skyblue.getCharacterImage(phase: level, size: size)
        case Character.yellow.rawValue:
            return Character.yellow.getCharacterImage(phase: level, size: size)
        case Character.white.rawValue:
            return Character.white.getCharacterImage(phase: level, size: size)
        default:
            return UIImage()
        }
    }
}
