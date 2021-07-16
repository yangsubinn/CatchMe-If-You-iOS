//
//  MainCardCVC.swift
//  CatchMe
//
//  Created by 양수빈 on 2021/07/06.
//

import UIKit

class MainCardCVC: UICollectionViewCell {
    static let identifier = "MainCardCVC"
    
    // MARK: - Properties
    let characterBackView = UIView()
    let characterImageView = UIImageView()
    let levelStarImageView = UIImageView()
    let nameLabel = UILabel()
    let labelBackView = UIView()
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
        setupLayout()
    }
    
    // MARK: - Custom Method
    func configUI() {
        self.layer.cornerRadius = 14
        self.backgroundColor = .clear
        
        nameLabel.textColor = .black200
        nameLabel.font = .catchuRegularSystemFont(ofSize: 14)
        nameLabel.addCharacterSpacing(kernValue: -0.6, paragraphValue: 5)
        nameLabel.numberOfLines = 2
        
        labelBackView.backgroundColor = UIColor.white.withAlphaComponent(0.7)
    }
    
    func setupLayout() {
        addSubviews([characterBackView, labelBackView, characterImageView, levelStarImageView, nameLabel])
        
        characterImageView.snp.makeConstraints { make in
            make.top.equalTo(levelStarImageView.snp.bottom).offset(9)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(101)
        }
        
        characterBackView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        levelStarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.centerX.equalToSuperview()
            make.width.equalTo(48)
            make.height.equalTo(14)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(labelBackView.snp.centerY)
            make.leading.equalToSuperview().inset(14)
            make.width.equalTo(127)
            make.height.equalTo(36)
        }
        
        labelBackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(144)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setImageView(level: Int, index: Int) {
        characterImageView.image = setCharacterImage(level: level, index: index, size: 101)
    }
    
    func setStarImageView(level: Int) -> UIImage? {
        switch level {
        case 1:
            return UIImage(named: "level1")
        case 2:
            return UIImage(named: "level2")
        case 3:
            return UIImage(named: "level3")
        default:
            return UIImage()
        }
    }
    
    func setStarLevel(level: Int) {
        levelStarImageView.image = setStarImageView(level: level)
    }
}
