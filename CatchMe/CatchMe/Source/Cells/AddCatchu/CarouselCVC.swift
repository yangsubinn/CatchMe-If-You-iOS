//
//  CarouselCVC.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/07.
//

import UIKit

import SnapKit

class CarouselCVC: UICollectionViewCell {
    static let identifier = "CarouselCVC"
    
    // MARK: - Properties
    let characterImageView = UIImageView()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        characterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Custom Method
    private func configUI() {
        addSubview(characterImageView)
    }
    
    func setupCharacter(image: UIImage) {
        characterImageView.image = image
    }
}
