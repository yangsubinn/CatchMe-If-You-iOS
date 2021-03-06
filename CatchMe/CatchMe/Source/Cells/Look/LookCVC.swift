//
//  LookCVC.swift
//  CatchMe
//
//  Created by μμλΉ on 2021/07/12.
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
            make.leading.equalTo(characterBackgroundView.snp.trailing).offset(20)
            make.width.equalTo(157)
            make.height.equalTo(18)
        }
        
        characterLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(8)
            make.leading.equalTo(characterBackgroundView.snp.trailing).offset(20)
            make.width.equalTo(157)
            make.height.lessThanOrEqualTo(46)
        }
        
        arrowButton.snp.makeConstraints { make in
            make.centerY.equalTo(nicknameLabel).offset(-1)
            make.leading.equalTo(nicknameLabel.snp.trailing).offset(10)
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
        
        nicknameLabel.text = "μΊμΉλ―ΈνΌμ λμ₯κΉν΄λ¦¬ λμ"
        nicknameLabel.textColor = .gray400
        nicknameLabel.font = .stringRegularSystemFont(ofSize: 14)
        nicknameLabel.addCharacterSpacing()
        
        characterLabel.text = "μ μ μμ  λλ€λλ€μ΄ κ±·κΈ° μ’μνλ μΊμΈ"
        characterLabel.textColor = .white
        characterLabel.font = .catchuRegularSystemFont(ofSize: 18)
        characterLabel.addCharacterSpacing()
        characterLabel.numberOfLines = 2
    }

    func setImageView(level: Int, index: Int) {
        characterImageView.image = setCharacterImage(level: level, index: index, size: 101)
    }
}
