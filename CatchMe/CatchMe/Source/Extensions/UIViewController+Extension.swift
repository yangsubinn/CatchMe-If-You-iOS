//
//  UIViewController+Extension.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/02.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setupStatusBar(_ color: UIColor) {
        if #available(iOS 13.0, *) {
            let margin = view.layoutMarginsGuide
            let statusbarView = UIView()
            statusbarView.backgroundColor = color
            statusbarView.frame = CGRect.zero
            view.addSubview(statusbarView)
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                statusbarView.topAnchor.constraint(equalTo: view.topAnchor),
                statusbarView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0),
                statusbarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                statusbarView.bottomAnchor.constraint(equalTo: margin.topAnchor)
            ])
            
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = color
        }
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
