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
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
        setupLayout()
    }
    
    // MARK: - Custom Method
    func configUI() {
        self.layer.cornerRadius = 14
        self.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        characterBackView.backgroundColor = .gray100
        characterImageView.image = Character.blue.getCharacterImage(phase: 2, size: 101)
        levelStarImageView.image = UIImage(named: "level2")
        
        nameLabel.text = "캐치미캐치유캐치미를정말정말좋아하는캐츄"
        nameLabel.textColor = .black200
        nameLabel.font = .catchuRegularSystemFont(ofSize: 14)
        nameLabel.addCharacterSpacing()
        nameLabel.numberOfLines = 2
    }
    
    func setupLayout() {
        addSubviews([characterBackView, characterImageView, levelStarImageView, nameLabel])
        
        characterImageView.snp.makeConstraints { make in
            make.top.equalTo(levelStarImageView.snp.bottom).offset(9)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(101)
        }
        
        characterBackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(144)
        }
        
        levelStarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.centerX.equalToSuperview()
            make.width.equalTo(48)
            make.height.equalTo(14)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(characterBackView.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(14)
            make.width.equalTo(127)
            make.height.equalTo(36)
        }
    }
}
