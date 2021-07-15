//
//  CharacterView.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/05.
//

import UIKit

import Then
import SnapKit

class CharacterView: UIView {
    // MARK: - Properties
    let lineTopView = UIView().then {
        $0.backgroundColor = .pink100
        $0.layer.cornerRadius = 2
    }
    
    let totalWordLabel = UILabel().then {
        $0.text = "총"
        $0.font = .stringRegularSystemFont(ofSize: 13)
        $0.textColor = .gray100
    }
    
    let catchingLabel = UILabel().then {
        $0.text = "캐칭"
        $0.font = .stringRegularSystemFont(ofSize: 13)
        $0.textColor = .gray100
    }
    
    let catchingCountLabel = UILabel().then {
        $0.font = .numberRegularSystemFont(ofSize: 13)
        $0.textColor = .gray100
    }
    
    let nameLabel = UILabel().then {
        $0.font = .catchuRegularSystemFont(ofSize: 19)
        $0.textColor = .black300
        $0.numberOfLines = 2
        $0.lineBreakMode = .byWordWrapping
    }
    
    let characterImageView = UIImageView()

    // MARK: - Life Cycle
    /// 후에 character default 이미지 name으로 character 변경
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        lineTopView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.leading.equalToSuperview().inset(22)
            make.height.equalTo(3)
            make.width.equalTo(29)
        }
        
        characterImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(5)
            make.height.width.equalTo(121)
        }
        
        totalWordLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(22)
            make.top.equalTo(lineTopView.snp.bottom).offset(8)
        }
        
        catchingCountLabel.snp.makeConstraints { make in
            make.leading.equalTo(totalWordLabel.snp.trailing).offset(3)
            make.top.equalTo(lineTopView.snp.bottom).offset(7)
        }
        
        catchingLabel.snp.makeConstraints { make in
            make.leading.equalTo(catchingCountLabel.snp.trailing).offset(1)
            make.top.equalTo(totalWordLabel.snp.top)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(22)
            make.top.equalTo(catchingLabel.snp.bottom).offset(20)
            make.trailing.equalTo(characterImageView.snp.leading)
            make.height.lessThanOrEqualTo(50)
        }
    }
    
    // MARK: - Custom Methods
    private func configUI() {
        addSubviews([lineTopView, totalWordLabel, catchingLabel,
                     catchingCountLabel, nameLabel, characterImageView])
        
        backgroundColor = .white
        layer.cornerRadius = 18
        
        catchingCountLabel.text = ""
        nameLabel.text = ""
        nameLabel.addCharacterSpacing()
        characterImageView.image = UIImage()
    }
    
    func setupEmptyView() {
        catchingCountLabel.text = "0"
        nameLabel.text = "아직 잡은\n캐츄가 없어요 !"
        nameLabel.addCharacterSpacing()
        characterImageView.image = UIImage(named: "catchu")
    }
    
    func setupCharacterView(catching: Int, name: String, character: UIImage?) {
        catchingCountLabel.text = "\(catching)"
        nameLabel.text = "\(name)"
        nameLabel.addCharacterSpacing()
        characterImageView.image = character
    }
}
