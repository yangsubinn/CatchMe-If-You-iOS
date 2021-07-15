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
    let characterBackgroundView  = UIView()
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
        addSubviews([characterBackgroundView, characterImageView, nicknameLabel,
                     characterLabel, arrowButton])
        
        characterImageView.snp.makeConstraints { make in
            make.center.equalTo(characterBackgroundView.snp.center)
            make.width.height.equalTo(65)
        }
        
        characterBackgroundView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(70)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalTo(characterBackgroundView.snp.trailing).offset(17)
            make.width.equalTo(157)
            make.height.equalTo(18)
        }
        
        characterLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(8)
            make.leading.equalTo(characterBackgroundView.snp.trailing).offset(17)
            make.width.equalTo(157)
            make.height.equalTo(46)
        }
        
        arrowButton.snp.makeConstraints { make in
            make.centerY.equalTo(nicknameLabel).offset(-1)
//            make.trailing.equalToSuperview().inset(UIScreen.main.hasNotch ? 60 : 46)
            make.leading.equalTo(nicknameLabel.snp.trailing).offset(2)
            make.width.equalTo(5)
            make.height.equalTo(10)
        }
    }
    
    func configUI() {
        self.layer.cornerRadius = 14
        self.backgroundColor = .black200
        characterBackgroundView.backgroundColor = .white
        characterBackgroundView.layer.cornerRadius = 36
        
        characterImageView.image = Character.purple.getCharacterImage(phase: 1, size: 65)
        arrowButton.setImage(UIImage(named: "icLookMore"), for: .normal)
        
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

    func setImageView(level: Int, index: Int) {
        characterImageView.image = setCharacterImage(level: level, index: index, size: 101)
    }
}
