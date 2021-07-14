//
//  ChangePasswordView.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/14.
//

import UIKit

import SnapKit

class ChangePasswordView: UIView {
    // MARK: - Properties
    let passwordTextField = CustomTextField(placeholder: "변경할 비밀번호 입력")
    let passwordTitleLabel = UILabel()
    let passwordLabel = UILabel()
    let currentImageView = UIImageView()
    
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
        addSubviews([passwordTextField, passwordTitleLabel, passwordLabel,
                     currentImageView])
        
        passwordTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(28)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTitleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(28)
        }
        
        currentImageView.snp.makeConstraints { make in
            make.centerY.equalTo(passwordTextField.snp.centerY)
            make.trailing.equalTo(passwordTextField.snp.trailing)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(40)
        }
    }
    
    private func configUI() {
        passwordTitleLabel.text = "비밀번호 변경"
        passwordTitleLabel.font = .stringMediumSystemFont(ofSize: 20)
        passwordTitleLabel.addCharacterSpacing()
        
        currentImageView.image = UIImage(named: "")
        
        passwordLabel.font = .stringRegularSystemFont(ofSize: 12)
        passwordLabel.text = "영문, 숫자, 특수문자 포함 8~16자"
        passwordLabel.textColor = .pink210
        passwordLabel.addCharacterSpacing()
        passwordLabel.isHidden = true
    }
    
    private func setupTextField() {
        passwordTextField.isSecureTextEntry = true
        passwordTextField.setRightPaddingPoints(48)
        passwordTextField.tintColor = .pink100
        passwordTextField.delegate = self
        passwordTextField.addTarget(self, action: #selector(changePWTextFieldUI), for: .allEditingEvents)
    }
}

extension ChangePasswordView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextFieldView()
        passwordTextField.setupPinkLine()
        currentImageView.image = UIImage(named: "")
        passwordLabel.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        backToOriginalView()
        passwordTextField.setupOriginalLine()
        
        if !passwordTextField.hasText {
            passwordLabel.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passwordTextField.resignFirstResponder()
        
        return true
    }
    
    
    
    @objc
    func changePWTextFieldUI(){
        if !(passwordTextField.text!.validatePassword()) && passwordTextField.hasText {
            passwordLabel.text = "비밀번호 조합조건이 틀렸습니다."
            passwordLabel.textColor = .red100
            currentImageView.image = UIImage(named: "icWarning")
        } else if passwordTextField.hasText {
            passwordLabel.text = "비밀번호 변경이 가능합니다."
            passwordLabel.textColor = .blue100
            currentImageView.image = UIImage(named: "icCheck")
        } else {
            passwordLabel.text = "영문, 숫자, 특수문자 포함 8~16자"
            passwordLabel.textColor = .pink210
            currentImageView.image = UIImage(named: "")
        }
        
        checkValidateUI()
    }
    
    func checkValidateUI(){
        /// Validate toggle
        if (passwordTextField.text!.validatePassword()) {
            checkValidate = true
        } else {
            checkValidate = false
        }
        
        /// Button isEnable
        if !(passwordTextField.text!.isEmpty) && checkValidate {
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
