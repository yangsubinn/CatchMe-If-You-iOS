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
        setupLayout()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    private func setupLayout() {
        addSubviews([backgroundImage, characterImage])
        
        backgroundImage.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(20)
            make.height.width.equalTo(130)
        }
        
        characterImage.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(4)
            make.leading.equalToSuperview().inset(25)
            make.height.width.equalTo(121)
        }
    }
    
    private func configUI() {
        backgroundImage.layer.cornerRadius = 65
    }
}
