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
    let currentLabel = UILabel()
    let checkLabel = UILabel()
    let currentImageView = UIImageView()
    let checkImageView = UIImageView()
    
    var registerButton = UIButton()
    var checkValidate = false
    
    // MARK: - Life Cycle
    
    init(button: UIButton) {
        super.init(frame: .zero)
        registerButton = button
        setupLayout()
        configUI()
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    private func setupLayout() {
        addSubviews([currentPWTitleLabel, passwordTextField, currentImageView,
                     checkPWTitleLabel, checkTextField, checkImageView,
                     currentLabel, checkLabel])
        
        currentPWTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(28)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(currentPWTitleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(28)
        }
        
        currentImageView.snp.makeConstraints { make in
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
        
        checkImageView.snp.makeConstraints { make in
            make.centerY.equalTo(checkTextField.snp.centerY)
            make.trailing.equalTo(checkTextField.snp.trailing)
        }
        
        currentLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(40)
        }
        
        checkLabel.snp.makeConstraints { make in
            make.top.equalTo(checkTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(40)
        }
    }
    
    private func configUI() {
        currentPWTitleLabel.text = "현재 비밀번호 입력"
        currentPWTitleLabel.font = .stringMediumSystemFont(ofSize: 20)
        currentPWTitleLabel.addCharacterSpacing()
        
        currentImageView.image = UIImage(named: "")
        
        checkPWTitleLabel.text = "비밀번호 확인"
        checkPWTitleLabel.font = .stringMediumSystemFont(ofSize: 20)
        checkPWTitleLabel.addCharacterSpacing()
        
        checkImageView.image = UIImage(named: "")
        
        currentLabel.font = .stringRegularSystemFont(ofSize: 12)
        currentLabel.addCharacterSpacing()
        
        checkLabel.font = .stringRegularSystemFont(ofSize: 12)
        checkLabel.addCharacterSpacing()
    }
    
    private func setupTextField() {
        passwordTextField.isSecureTextEntry = true
        passwordTextField.setRightPaddingPoints(48)
        passwordTextField.tintColor = .pink100
        passwordTextField.delegate = self
        passwordTextField.addTarget(self, action: #selector(changePWTextFieldUI), for: .allEditingEvents)
        
        checkTextField.isSecureTextEntry = true
        checkTextField.setRightPaddingPoints(48)
        checkTextField.tintColor = .pink100
        checkTextField.delegate = self
        checkTextField.addTarget(self, action: #selector(checkPWTextfieldUI), for: .allEditingEvents)
    }
}

extension CurrentPasswordView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextFieldView()
        switch textField {
        case passwordTextField:
            passwordTextField.setupPinkLine()
            currentImageView.image = UIImage(named: "")
            currentLabel.text = ""
        default:
            checkTextField.setupPinkLine()
            checkImageView.image = UIImage(named: "")
            checkLabel.text = ""
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        backToOriginalView()
        switch textField {
        case passwordTextField:
            passwordTextField.setupOriginalLine()
            
            if !passwordTextField.hasText {
                currentLabel.text = ""
            }
        default:
            checkTextField.setupOriginalLine()
            
            if !checkTextField.hasText {
                checkLabel.text = ""
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case passwordTextField:
            checkTextField.becomeFirstResponder()
        default:
            checkTextField.resignFirstResponder()
        }
        
        return true
    }
    
    @objc
    func changePWTextFieldUI(){
        if checkTextField.hasText {
            if !(passwordTextField.text == checkTextField.text) {
                checkImageView.image = UIImage(named: "icWarning")
                checkLabel.text = "비밀번호가 일치하지 않습니다."
            } else if passwordTextField.hasText {
                checkImageView.image = UIImage(named: "icCheck")
                checkLabel.text = ""
            }
        } else {
            checkImageView.image = UIImage(named: "")
            checkLabel.text = ""
        }
        
        checkValidateUI()
    }
    
    @objc
    func checkPWTextfieldUI(){
        if !(passwordTextField.text == checkTextField.text) && checkTextField.hasText {
            checkLabel.text = "비밀번호가 일치하지 않습니다."
            checkLabel.textColor = .red100
            checkImageView.image = UIImage(named: "icWarning")
        } else if checkTextField.hasText {
            checkLabel.text = ""
            checkImageView.image = UIImage(named: "icCheck")
        } else {
            checkLabel.text = "비밀번호를 다시 입력해주세요."
            checkLabel.textColor = .pink210
            checkImageView.image = UIImage(named: "")
        }
        
        checkValidateUI()
    }
    
    func checkValidateUI(){
        /// Validate toggle
        if (passwordTextField.text == checkTextField.text) {
            checkValidate = true
        } else {
            checkValidate = false
        }
        
        /// Button isEnable
        if !(passwordTextField.text!.isEmpty) && !(passwordTextField.text!.isEmpty) && checkValidate {
            registerButton.isEnabled = true
            registerButton.backgroundColor = .pink100
        } else {
            registerButton.isEnabled = false
            registerButton.backgroundColor = .gray300
        }
    }
    
    private func moveTextFieldView() {
        UIView.animate(withDuration: 0.2, animations: {
            self.registerButton.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.hasNotch ? -UIScreen.main.bounds.size.height * 0.32 : -180)
        })
    }
    
    private func backToOriginalView() {
        UIView.animate(withDuration: 0.2, animations: {
            self.registerButton.transform = .identity
        })
    }
}
