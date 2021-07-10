//
//  TextFieldView.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/09.
//

import UIKit

import SnapKit

class TextFieldView: UIView {
    // MARK: - Properties
    let emailTextField = CustomTextField(placeholder: "이메일")
    let passwordTextField = CustomTextField(placeholder: "비밀번호")
    let loginButton = BottomButton(title: "로그인")
    let autoLabel = UILabel()
    let memberLabel = UILabel()
    let emailMessageLabel = UILabel()
    let passwordMessageLabel = UILabel()
    let autoButton = UIButton()
    let memberButton = UIButton()
    let secureButton = UIButton()
    
    var logoImageView = UIImageView()
    var isAuto = true
    
    // MARK: - Dummy Data
    let id = "tlsdbsdk0525"
    let pw = "catchme"

    // MARK: - Life Cycle
    init(logo: UIImageView) {
        super.init(frame: .zero)
        logoImageView = logo
        setupLayout()
        configUI()
        setupTextField()
        setupButtonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    private func setupLayout() {
        addSubviews([emailTextField, passwordTextField, autoButton,
                     autoLabel, loginButton, memberLabel,
                     memberButton, secureButton, emailMessageLabel,
                     passwordMessageLabel])
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(28)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(36)
            make.leading.trailing.equalTo(emailTextField)
        }
        
        autoButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(32)
            make.leading.equalToSuperview().inset(40)
            make.height.width.equalTo(34)
        }
        
        autoLabel.snp.makeConstraints { make in
            make.centerY.equalTo(autoButton.snp.centerY)
            make.leading.equalTo(autoButton.snp.trailing).offset(4)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(112)
            make.leading.trailing.equalToSuperview().inset(28)
        }
        
        memberLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(33)
            make.leading.equalToSuperview().inset(UIScreen.main.bounds.size.width * 0.25)
        }
        
        memberButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(18)
            make.leading.equalTo(memberLabel.snp.trailing)
            make.bottom.equalToSuperview()
            make.width.equalTo(76)
            make.height.equalTo(48)
        }
        
        secureButton.snp.makeConstraints { make in
            make.centerY.equalTo(passwordTextField.snp.centerY)
            make.trailing.equalTo(passwordTextField.snp.trailing).inset(6)
            make.width.height.equalTo(48)
        }
        
        emailMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(6)
            make.leading.equalToSuperview().inset(43)
        }
        
        passwordMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(6)
            make.leading.equalToSuperview().inset(43)
        }
    }
    
    private func configUI() {
        autoButton.backgroundColor = .systemPink
        
        autoLabel.font = .systemFont(ofSize: 15, weight: .light)
        autoLabel.text = "자동 로그인"
        
        memberLabel.font = .systemFont(ofSize: 14)
        memberLabel.text = "아직회원이 아니신가요?"
        
        emailMessageLabel.font = .systemFont(ofSize: 12)
        emailMessageLabel.textColor = .pink210
        emailMessageLabel.text = "존재하지 않는 사용자입니다."
        emailMessageLabel.isHidden = true
        
        passwordMessageLabel.font = .systemFont(ofSize: 12)
        passwordMessageLabel.textColor = .pink210
        passwordMessageLabel.text = "비밀번호가 틀렸습니다."
        passwordMessageLabel.isHidden = true
        
        memberButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        memberButton.setTitle("회원가입", for: .normal)
        memberButton.drawUnderline()
        
        secureButton.backgroundColor = .purple
        secureButton.isHidden = true
    }
    
    private func setupTextField() {
        emailTextField.delegate = self
        emailTextField.changePaddingPoints(point: 50)
        emailTextField.setupEmailImage()
        emailTextField.font = .systemFont(ofSize: 17)
        emailTextField.textColor = .black100
        emailTextField.tintColor = .pink100
        
        passwordTextField.delegate = self
        passwordTextField.changePaddingPoints(point: 50)
        passwordTextField.setRightPaddingPoints(54)
        passwordTextField.setupPasswordImage()
        passwordTextField.font = .systemFont(ofSize: 17)
        passwordTextField.textColor = .black100
        passwordTextField.tintColor = .pink100
    }
    
    private func setupButtonAction() {
        let autoAction = UIAction { _ in
            self.autoButton.backgroundColor = self.isAuto ? .gray : .systemPink
            self.isAuto.toggle()
        }
        autoButton.addAction(autoAction, for: .touchUpInside)
        
        let secureAction = UIAction { _ in
            self.secureButton.backgroundColor = self.passwordTextField.isSecureTextEntry ? .gray : .purple
            self.passwordTextField.isSecureTextEntry.toggle()
        }
        secureButton.addAction(secureAction, for: .touchUpInside)
        
        let loginAction = UIAction { _ in
            if let emailText = self.emailTextField.text,
               let pwText = self.passwordTextField.text {
                if emailText != self.id {
                    self.emailMessageLabel.isHidden = false
                } else if pwText != self.pw {
                    self.passwordMessageLabel.isHidden = false
                } else {
                    /// 로그인 성공 로직
                    self.emailMessageLabel.isHidden = true
                    self.passwordMessageLabel.isHidden = true
                    
                    UIView.animate(withDuration: 0.2, animations: {
                        self.transform = .identity
                    })
                    
                    self.logoImageView.fadeIn()
                    self.passwordTextField.resignFirstResponder()
                }
            }
        }
        loginButton.addAction(loginAction, for: .touchUpInside)
    }
}

// MARK: - UITextFieldDelegate
extension TextFieldView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.hasNotch ? -160 : -140)
        })
        
        logoImageView.fadeOut()
        
        emailMessageLabel.isHidden = true
        passwordMessageLabel.isHidden = true
        
        switch textField {
        case emailTextField:
            emailTextField.emailImageView.isHidden = true
            emailTextField.changePaddingPoints(point: 21)
            emailTextField.backgroundColor = .white
        default:
            passwordTextField.passwordImageView.isHidden = true
            passwordTextField.changePaddingPoints(point: 21)
            passwordTextField.backgroundColor = .white
            
            secureButton.isHidden = false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = .identity
        })
        
        switch textField {
        case emailTextField:
            emailTextField.emailImageView.isHidden = textField.hasText
            emailTextField.changePaddingPoints(point: textField.hasText ? 21 : 50)
            emailTextField.backgroundColor = textField.hasText ? .white : .black200
        default:
            passwordTextField.passwordImageView.isHidden = textField.hasText
            passwordTextField.changePaddingPoints(point: textField.hasText ? 21 : 50)
            passwordTextField.backgroundColor = textField.hasText ? .white : .black200
            
            secureButton.isHidden = !textField.hasText
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        default:
            passwordTextField.resignFirstResponder()
            logoImageView.fadeIn()
        }
        
        return true
    }
}
