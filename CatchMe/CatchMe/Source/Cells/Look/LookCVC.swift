//
//  LookCVC.swift
//  CatchMe
//
//  Created by 양수빈 on 2021/07/12.
//

import UIKit

class LookCVC: UICollectionViewCell {
    static let identifier = "LookCVC"
    
    //MARK: - Properties
    let characterImageView = UIImageView()
    let nicknameLabel = UILabel()
    let characterLabel = UILabel()
    let arrowButton = UIButton()

    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
        configUI()
    }
    
    //MARK: - Custom Method
    func setupLayout() {
        addSubviews([characterImageView, nicknameLabel, characterLabel,
                     arrowButton])
        
        characterImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(11)
            make.width.height.equalTo(85)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalTo(characterImageView.snp.trailing).offset(11)
        }
        
        characterLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(8)
            make.leading.equalTo(characterImageView.snp.trailing).offset(11)
            make.width.equalTo(170)
            make.height.equalTo(46)
        }
        
        arrowButton.snp.makeConstraints { make in
            make.centerY.equalTo(nicknameLabel)
            make.trailing.equalToSuperview().inset(40)
            make.width.equalTo(5)
            make.height.equalTo(10)
        }
    }
    
    func configUI() {
        self.layer.cornerRadius = 14
        self.backgroundColor = .black100
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.green.cgColor
            
        characterImageView.backgroundColor = .pink000
        arrowButton.backgroundColor = .yellow
        
        nicknameLabel.text = "캐치미피엠대장김해리 님의"
        nicknameLabel.textColor = .gray400
        nicknameLabel.font = .stringMediumSystemFont(ofSize: 14)
        
        characterLabel.text = "캐치미없이캐치미없이못살아못살아캐치미짱"
        characterLabel.textColor = .white
        characterLabel.font = .catchuRegularSystemFont(ofSize: 18)
        characterLabel.lineBreakMode = .byWordWrapping
        characterLabel.numberOfLines = 2
    }

}
