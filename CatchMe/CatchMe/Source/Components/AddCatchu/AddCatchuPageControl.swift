//
//  AddCatchuPageControl.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/07.
//

import UIKit

class AddCatchuPageControl: UIView {
    var pages: Int = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    var selectedPage: Int = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var dotColor = UIColor.lightGray {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var selectedColor = UIColor.init(red: 234/255, green: 69/255, blue: 121/255, alpha: 1.0) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private let dotSize: CGFloat = 6
    private let spacing: CGFloat = 6
    
    init() {
        super.init(frame: .zero)
        isOpaque = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func draw(_ rect: CGRect) {
        (0..<pages).forEach { page in
            (page == selectedPage ? selectedColor : dotColor).setFill()
            let center = CGPoint(x: rect.minX + dotSize / 2 + (dotSize + spacing) * CGFloat(page), y: rect.midY)
            let size = CGSize(width: 6, height: 6)
            let rect = CGRect(origin: center, size: size)
            UIBezierPath(roundedRect: rect, cornerRadius: 3).fill()
        }
    }
}
