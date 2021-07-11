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
    var dateLabel = UILabel()
    var countLabel = UILabel()
    var characterImage = UIImageView().then {
        $0.isHidden = true
        $0.image = Character.orange.getCharacterImage(phase: 3, size: 43)
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
        addSubviews([dateLabel, characterImage, countLabel])
        
        dateLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
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
