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
    var rootVC = UIViewController()
    var isAuto = true
    
    // MARK: - Connect Server
    let viewModel = LoginViewModel.shared

    // MARK: - Life Cycle
    init(logo: UIImageView, vc: UIViewController) {
        super.init(frame: .zero)
        rootVC = vc
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
        autoButton.setImage(UIImage(named: "checkboxActive"), for: .normal)
        
        autoLabel.font = .stringRegularSystemFont(ofSize: 15)
        autoLabel.textColor = .white
        autoLabel.text = "자동 로그인"
        
        memberLabel.font = .stringRegularSystemFont(ofSize: 14)
        memberLabel.text = "아직회원이 아니신가요?"
        
        emailMessageLabel.font = .stringRegularSystemFont(ofSize: 12)
        emailMessageLabel.textColor = .pink210
        emailMessageLabel.text = "존재하지 않는 사용자입니다."
        emailMessageLabel.isHidden = true
        
        passwordMessageLabel.font = .stringRegularSystemFont(ofSize: 12)
        passwordMessageLabel.textColor = .pink210
        passwordMessageLabel.text = "비밀번호가 틀렸습니다."
        passwordMessageLabel.isHidden = true
        
        memberButton.titleLabel?.font = .stringMediumSystemFont(ofSize: 14)
        memberButton.setTitle("회원가입", for: .normal)
        memberButton.drawUnderline()
        
        secureButton.setImage(UIImage(named: "icEyeOff"), for: .normal)
        secureButton.isHidden = true
    }
    
    private func setupTextField() {
        emailTextField.delegate = self
        emailTextField.changePaddingPoints(point: 50)
        emailTextField.setupEmailImage()
        emailTextField.font = .stringRegularSystemFont(ofSize: 17)
        emailTextField.textColor = .black100
        emailTextField.tintColor = .pink100
        
        passwordTextField.delegate = self
        passwordTextField.changePaddingPoints(point: 50)
        passwordTextField.setRightPaddingPoints(54)
        passwordTextField.setupPasswordImage()
        passwordTextField.font = .stringRegularSystemFont(ofSize: 17)
        passwordTextField.textColor = .black100
        passwordTextField.tintColor = .pink100
        
        addObserver()
    }
    
    private func setupButtonAction() {
        let autoAction = UIAction { _ in
            self.autoButton.setImage(self.isAuto ? UIImage(named: "checkboxInactive") : UIImage(named: "checkboxActive"), for: .normal)
            self.isAuto.toggle()
        }
        autoButton.addAction(autoAction, for: .touchUpInside)
        
        let secureAction = UIAction { _ in
            self.secureButton.setImage(UIImage(named: self.passwordTextField.isSecureTextEntry ? "icEyeOn" : "icEyeOff"), for: .normal)
            self.passwordTextField.isSecureTextEntry.toggle()
        }
        secureButton.addAction(secureAction, for: .touchUpInside)
        
        let loginAction = UIAction { _ in
            if let emailText = self.emailTextField.text,
               let pwText = self.passwordTextField.text {
                self.viewModel.dispatchLogin(email: emailText, password: pwText) { result in
                    switch result {
                    case 200:
                        self.emailMessageLabel.isHidden = true
                        self.passwordMessageLabel.isHidden = true
                        
                        UIView.animate(withDuration: 0.2, animations: {
                            self.transform = .identity
                        })
                        
                        self.logoImageView.fadeIn()
                        self.passwordTextField.resignFirstResponder()
                        
                        let dvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainNavi")
                        dvc.modalPresentationStyle = .fullScreen
                        self.rootVC.present(dvc, animated: true, completion: nil)
                    case 412:
                        self.passwordMessageLabel.isHidden = false
                    default:
                        self.emailMessageLabel.isHidden = false
                    }
                }
            }
        }
        loginButton.addAction(loginAction, for: .touchUpInside)
        
        let signupAction = UIAction { _ in
            guard let vc = self.rootVC.storyboard?.instantiateViewController(withIdentifier: "SignupVC") as? SignupVC else { return }
            self.rootVC.navigationController?.pushViewController(vc, animated: true)
        }
        memberButton.addAction(signupAction, for: .touchUpInside)
    }
    
    // MARK: - Notification
    func addObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(reloadUI), name: .signupVC, object: nil)
    }
    
    @objc
    func reloadUI(_ notification: NSNotification) {
        guard let userEmail = notification.userInfo?["username"] as? String else { return }
        guard let userPW = notification.userInfo?["userpw"] as? String else { return }
        
        emailTextField.text = userEmail
        emailTextField.emailImageView.isHidden = true
        emailTextField.changePaddingPoints(point: 21)
        emailTextField.backgroundColor = .white
        
        passwordTextField.text = userPW
        passwordTextField.passwordImageView.isHidden = true
        passwordTextField.changePaddingPoints(point: 21)
        passwordTextField.backgroundColor = .white
            
        secureButton.isHidden = false
    }
}

// MARK: - UITextFieldDelegate
extension TextFieldView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.287, animations: {
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
        UIView.animate(withDuration: 0.287, animations: {
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
