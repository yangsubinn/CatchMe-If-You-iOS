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
        $0.contentMode = .scaleAspectFit
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
            make.top.equalToSuperview().offset(UIScreen.main.hasNotch ? 0 : 2)
            make.height.equalTo(UIScreen.main.hasNotch ? 40 : 31)
            make.width.equalTo(43)
        }
        
        countLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
