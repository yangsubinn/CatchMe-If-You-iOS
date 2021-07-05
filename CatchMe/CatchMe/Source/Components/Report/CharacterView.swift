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
        $0.backgroundColor = .systemPink
        $0.layer.cornerRadius = 2
    }
    
    let totalWordLabel = UILabel().then {
        $0.text = "총"
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .gray
    }
    
    let catchingLabel = UILabel().then {
        $0.text = "캐칭"
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .gray
    }
    
    let catchingCountLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .gray
    }
    
    let nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 19, weight: .bold)
        $0.numberOfLines = 2
        $0.lineBreakMode = .byWordWrapping
    }
    
    let characterImageView = UIImageView()

    // MARK: - Life Cycle
    init(catching: Int, name: String, character: String) {
        super.init(frame: .zero)
        configUI(catching: catching, name: name, character: character)
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
            make.height.width.equalTo(120)
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
            make.width.equalTo(105)
            make.height.lessThanOrEqualTo(50)
        }
    }
    
    // MARK: - Custom Methods
    private func configUI(catching: Int, name: String, character: String) {
        addSubviews([lineTopView, totalWordLabel, catchingLabel,
                     catchingCountLabel, nameLabel, characterImageView])
        
        backgroundColor = .white
        layer.cornerRadius = 20
        
        catchingCountLabel.text = "\(catching)"
        nameLabel.text = name
        characterImageView.backgroundColor = .systemGreen
    }
}
