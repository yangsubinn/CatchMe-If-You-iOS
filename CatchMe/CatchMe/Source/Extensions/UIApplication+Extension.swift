//
//  UIApplication+Extension.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/10.
//

import UIKit

extension UIApplication {
    static var statusBarHeight: CGFloat {
//        if #available(iOS 13.0, *) {
//            let window = shared.windows.filter { $0.isKeyWindow }.first
//            return window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
//        }
//        
        return shared.statusBarFrame.height
    }
}
