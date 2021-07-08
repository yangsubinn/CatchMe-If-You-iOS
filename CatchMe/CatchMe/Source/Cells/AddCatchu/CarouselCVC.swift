//
//  CarouselCVC.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/07.
//

import UIKit

class CarouselCVC: UICollectionViewCell {
    static let identifier = "CarouselCVC"
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    /// asset 넣기 전까지 dummy Color
    func setupCharacter(color: UIColor) {
        backgroundColor = color
    }
}
