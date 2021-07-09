//
//  SignupTextFieldView.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/10.
//

import UIKit

import SnapKit

class SignupTextFieldView: UIView {
    // MARK: - Properties
    let emailLabel = UILabel()
    let idLabel = UILabel()
    let passwordLabel = UILabel()
    let checkPasswordLabel = UILabel()
    let emailTextField = CustomTextField(placeholder: "이메일 입력", small: true)
    let idTextField = CustomTextField(placeholder: "아이디 입력", small: true)
    let passwordTextField = CustomTextField(placeholder: "비밀번호 입력", small: true)
    let checkPasswordTextField = CustomTextField(placeholder: "비밀번호 입력", small: true)
    let checkButton = UIButton()

    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    private func setupLayout() {
        addSubviews([emailLabel, emailTextField, checkButton, idLabel,
                     idTextField, passwordLabel, passwordTextField,
                     checkPasswordLabel, checkPasswordTextField])
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(28)
        }
        
        checkButton.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(12)
            make.trailing.equalToSuperview().inset(28)
            make.width.equalTo(52)
            make.height.equalTo(48)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(checkButton.snp.top)
            make.leading.equalTo(emailLabel.snp.leading)
            make.trailing.equalTo(checkButton.snp.leading).offset(-5)
        }
        
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(45)
            make.leading.equalTo(emailLabel.snp.leading)
        }
        
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(idLabel.snp.bottom).offset(12)
            make.leading.equalTo(emailTextField.snp.leading)
            make.trailing.equalTo(checkButton.snp.trailing)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(45)
            make.leading.equalTo(emailTextField.snp.leading)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(12)
            make.leading.equalTo(emailTextField.snp.leading)
            make.trailing.equalTo(checkButton.snp.trailing)
        }
        
        checkPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(45)
            make.leading.equalTo(emailTextField.snp.leading)
        }
        
        checkPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(checkPasswordLabel.snp.bottom).offset(12)
            make.bottom.equalToSuperview().inset(22)
            make.leading.equalTo(emailTextField.snp.leading)
            make.trailing.equalTo(checkButton.snp.trailing)
        }
    }
    
    private func configUI() {
        emailLabel.text = "이메일 주소"
        emailLabel.font = .systemFont(ofSize: 18, weight: .medium)
        
        idLabel.text = "아이디(닉네임)"
        idLabel.font = .systemFont(ofSize: 18, weight: .medium)
        
        passwordLabel.text = "비밀번호"
        passwordLabel.font = .systemFont(ofSize: 18, weight: .medium)
        
        checkPasswordLabel.text = "비밀번호 확인"
        checkPasswordLabel.font = .systemFont(ofSize: 18, weight: .medium)
        
        checkButton.setTitle("확인", for: .normal)
        checkButton.setTitleColor(.white, for: .normal)
        checkButton.titleLabel?.font = .systemFont(ofSize: 14)
        checkButton.backgroundColor = .gray50
        checkButton.layer.cornerRadius = 13
    }
}
