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
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    private func setupLayout() {
        addSubviews([currentPWTitleLabel, passwordTextField, currentRemoveButton,
                     checkPWTitleLabel, checkTextField, checkRemoveButton])
        
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
        
        checkPWTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(45)
            make.leading.equalToSuperview().inset(28)
        }
        
        checkTextField.snp.makeConstraints { make in
            make.top.equalTo(checkPWTitleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(28)
        }
        
        checkRemoveButton.snp.makeConstraints { make in
            make.centerY.equalTo(checkTextField.snp.centerY)
            make.trailing.equalTo(checkTextField.snp.trailing)
        }
    }
    
    private func configUI() {
        currentPWTitleLabel.text = "현재 비밀번호 입력"
        currentPWTitleLabel.font = .stringMediumSystemFont(ofSize: 20)
        currentPWTitleLabel.addCharacterSpacing()
        
        currentRemoveButton.setImage(UIImage(named: "btnRemove"), for: .normal)
        currentRemoveButton.isHidden = true
        
        checkPWTitleLabel.text = "비밀번호 확인"
        checkPWTitleLabel.font = .stringMediumSystemFont(ofSize: 20)
        checkPWTitleLabel.addCharacterSpacing()
        
        checkRemoveButton.setImage(UIImage(named: "btnRemove"), for: .normal)
        checkRemoveButton.isHidden = true
    }
    
    private func setupTextField() {
        passwordTextField.isSecureTextEntry = true
        passwordTextField.setRightPaddingPoints(48)
        passwordTextField.delegate = self
        
        checkTextField.isSecureTextEntry = true
        checkTextField.setRightPaddingPoints(48)
        checkTextField.delegate = self
    }
}

extension CurrentPasswordView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case passwordTextField:
            currentRemoveButton.isHidden = false
        default:
            checkRemoveButton.isHidden = false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case passwordTextField:
            currentRemoveButton.isHidden = true
        default:
            checkRemoveButton.isHidden = true
        }
    }
}
