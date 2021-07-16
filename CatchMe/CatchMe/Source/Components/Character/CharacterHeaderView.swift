//
//  CharacterHeaderView.swift
//  CatchMe
//
//  Created by Thisisme Hi on 2021/07/04.
//

import UIKit

import Then
import SnapKit

class CharacterHeaderView: UIView {
    // MARK: - Properties
//    let vc = CharacterVC()
    
    let shadowImageView = UIImageView().then {
        $0.image = UIImage(named: "catchuScrollRectangle131")
        $0.layer.masksToBounds = false
    }
    
    let lockDateStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .center
    }
    
    let lockImageView = UIImageView().then {
        $0.image = UIImage(named: "icLock")
    }
    
    let dateLabel = UILabel().then {
        $0.font = .numberRegularSystemFont(ofSize: 15)
        $0.textAlignment = .left
        $0.textColor = .gray310
        $0.addCharacterSpacing(kernValue: -0.09, paragraphValue: 0)
    }
    
    let fromLabel = UILabel().then {
        $0.text = "부터"
        $0.font = .stringRegularSystemFont(ofSize: 12)
        $0.textAlignment = .left
        $0.textColor = .gray310
        $0.addCharacterSpacing(kernValue: -0.07, paragraphValue: 0)
    }
    
    let writeButton = UIButton().then {
        $0.setImage(UIImage(named: "btnWrite"), for: .normal)
    }
    
    let nameView = UIView()
    
    let nameLabel = UILabel().then {
//        $0.text = "캐치미를정말좋아하는동글귀염보라돌이캐츄"
        $0.font = .catchuRegularSystemFont(ofSize: 21)
        $0.textAlignment = .left
        $0.textColor = .white
        $0.numberOfLines = 2
        $0.lineBreakMode = .byWordWrapping
        $0.addCharacterSpacing(kernValue: -0.6, paragraphValue: 4)
    }
    
    // MARK: - Lifecycle
    init(date: String = "", name: String = "", isDetail: Bool) {
        super.init(frame: .zero)
        configUI(date: date, name: name, isDetail: isDetail)
        setupAutoLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    func configUI(date: String, name: String, isDetail: Bool) {
        backgroundColor = .black100
        
        dateLabel.text = date
        nameLabel.text = name
        writeButton.isHidden = isDetail
    }
        
    private func setupAutoLayout() {
        addSubviews([shadowImageView, lockDateStackView, fromLabel,
                     writeButton, nameView, nameLabel])
        lockDateStackView.addArrangedSubview(lockImageView)
        lockDateStackView.addArrangedSubview(dateLabel)
        
        lockImageView.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        lockDateStackView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(19)
            make.leading.equalTo(self.snp.leading).inset(26)
        }
        
        fromLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(23)
            make.leading.equalTo(lockDateStackView.snp.trailing).offset(1)
        }
        
        writeButton.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(20)
            make.trailing.equalToSuperview().inset(28)
            make.width.equalTo(91)
            make.height.equalTo(38)
        }
        
        nameView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(13)
            make.leading.equalToSuperview().inset(28)
            make.width.equalTo(192)
            make.height.lessThanOrEqualTo(54)
        }
            
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nameView.snp.centerY)
            make.leading.equalTo(nameView.snp.leading)
            make.trailing.equalTo(nameView.snp.trailing)
        }
    }
    
    func setupLabel(name: String) {
        nameLabel.text = name
    }
}
