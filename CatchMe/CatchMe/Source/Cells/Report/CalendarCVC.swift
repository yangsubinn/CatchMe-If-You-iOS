//
//  CalendarCVC.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/06.
//

import UIKit

import Then
import SnapKit

class CalendarCVC: UICollectionViewCell {
    static let identifier = "CalendarCVC"
    
    // MARK: - Properties
    var dataLabel = UILabel()
    var countLabel = UILabel()
    var characterImage = UIImageView().then {
        $0.isHidden = true
        $0.backgroundColor = .systemBlue
    }
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    private func setupLayout() {
        addSubviews([dataLabel, characterImage, countLabel])
        
        dataLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        characterImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(7)
            make.height.equalTo(27)
            make.width.equalTo(32)
        }
        
        countLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(characterImage.snp.bottom).offset(1)
        }
    }
}
