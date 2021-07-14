//
//  CurrentPasswordView.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/14.
//

import UIKit

import SnapKit

class CurrentPasswordView: UIView {
    // MARK: - Properties
    let passwordTextField = CustomTextField(placeholder: "현재 비밀번호 입력")
    let checkTextField = CustomTextField(placeholder: "현재 비밀번호 입력")
    let currentPWTitleLabel = UILabel()
    let checkPWTitleLabel = UILabel()
    let currentRemoveButton = UIButton()
    let checkRemoveButton = UIButton()
    
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    private func setupLayout() {
        addSubviews([currentPWTitleLabel, passwordTextField, currentRemoveButton,
                     ])
        
        currentPWTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(28)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(currentPWTitleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(28)
        }
        
        currentRemoveButton.snp.makeConstraints { make in
            make.centerY.equalTo(passwordTextField.snp.centerY)
            make.trailing.equalTo(passwordTextField.snp.trailing)
        }
    }
    
    private func configUI() {
        currentPWTitleLabel.text = "현재 비밀번호 입력"
        currentPWTitleLabel.font = .stringMediumSystemFont(ofSize: 20)
        currentPWTitleLabel.addCharacterSpacing()
        
        currentRemoveButton.setImage(UIImage(named: "btnRemove"), for: .normal)
    }
}
