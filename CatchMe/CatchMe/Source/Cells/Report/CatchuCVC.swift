//
//  CatchuCVC.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/06.
//

import UIKit

import SnapKit

class CatchuCVC: UICollectionViewCell {
    static let identifier = "CatchuCVC"
    
    // MARK: - Properties
    var characterImage = UIImageView()
    var backgroundImage = UIImageView()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    private func configUI() {
        backgroundImage.backgroundColor = .blue100
    }
    
    private func setupLayout() {
        addSubviews([backgroundImage, characterImage])
        
        backgroundImage.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(150)
        }
        
        characterImage.snp.makeConstraints { make in
            make.bottom.equalTo(backgroundImage.snp.bottom)
            make.leading.equalTo(backgroundImage.snp.leading)
            make.height.width.equalTo(121)
        }
    }
}
