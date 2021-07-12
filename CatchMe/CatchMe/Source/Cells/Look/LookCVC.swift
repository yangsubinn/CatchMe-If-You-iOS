//
//  LookCVC.swift
//  CatchMe
//
//  Created by 양수빈 on 2021/07/12.
//

import UIKit

import SnapKit

class LookCVC: UICollectionViewCell {
    static let identifier = "LookCVC"
    
    //MARK: - Properties
    let characterImageView = UIImageView()
    let characterBackgroungView  = UIView()
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
        addSubviews([characterBackgroungView, characterImageView, nicknameLabel,
                     characterLabel, arrowButton])
        
        characterImageView.snp.makeConstraints { make in
            make.center.equalTo(characterBackgroungView.snp.center)
            make.width.height.equalTo(65)
        }
        
        characterBackgroungView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(70)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalTo(characterBackgroungView.snp.trailing).offset(17)
            make.width.equalTo(157)
            make.height.equalTo(18)
        }
        
        characterLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(8)
            make.leading.equalTo(characterBackgroungView.snp.trailing).offset(17)
            make.width.equalTo(157)
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
        self.backgroundColor = .black200
            
        characterImageView.backgroundColor = .pink000
        characterBackgroungView.backgroundColor = .yellow
        characterBackgroungView.layer.cornerRadius = 36 //UIScreen.main.bound
        arrowButton.backgroundColor = .yellow
        
        nicknameLabel.text = "캐치미피엠대장김해리 님의"
        nicknameLabel.textColor = .gray400
        nicknameLabel.font = .stringRegularSystemFont(ofSize: 14)
        nicknameLabel.addCharacterSpacing()
        
        characterLabel.text = "유유자적 동네나들이 걷기 좋아하는 캐츄"
        characterLabel.textColor = .white
        characterLabel.font = .catchuRegularSystemFont(ofSize: 18)
        characterLabel.addCharacterSpacing()
        characterLabel.numberOfLines = 2
    }

}
