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
    let doubleCheckButton = UIButton()
    
    /// Additional Properties
    let emailMessageLabel = UILabel()
    let emailButton = UIButton()
    let idCountLabel = UILabel()

    var registerButton = UIButton()
    var doubleCheck = false
    var checkValidate = false
    var textCount = 0
    
    // MARK: - Dummy Data
    let email = "catchme0717@gmail.com"

    // MARK: - Life Cycle
    init(_ button: UIButton) {
        super.init(frame: .zero)
        registerButton = button
        setupLayout()
        setupAdditionalLayout()
        configUI()
        setupButtonAction()
        changeTextFields()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    private func setupLayout() {
        addSubviews([emailLabel, emailTextField, doubleCheckButton, idLabel,
                     idTextField, passwordLabel, passwordTextField,
                     checkPasswordLabel, checkPasswordTextField])
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(28)
        }
        
        doubleCheckButton.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(12)
            make.trailing.equalToSuperview().inset(28)
            make.width.equalTo(52)
            make.height.equalTo(48)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(doubleCheckButton.snp.top)
            make.leading.equalTo(emailLabel.snp.leading)
            make.trailing.equalTo(doubleCheckButton.snp.leading).offset(-5)
        }
        
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(UIScreen.main.hasNotch ? 45 : 30)
            make.leading.equalTo(emailLabel.snp.leading)
        }
        
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(idLabel.snp.bottom).offset(12)
            make.leading.equalTo(emailTextField.snp.leading)
            make.trailing.equalTo(doubleCheckButton.snp.trailing)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(UIScreen.main.hasNotch ? 45 : 30)
            make.leading.equalTo(emailTextField.snp.leading)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(12)
            make.leading.equalTo(emailTextField.snp.leading)
            make.trailing.equalTo(doubleCheckButton.snp.trailing)
        }
        
        checkPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(UIScreen.main.hasNotch ? 45 : 30)
            make.leading.equalTo(emailTextField.snp.leading)
        }
        
        checkPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(checkPasswordLabel.snp.bottom).offset(12)
            make.bottom.equalToSuperview().inset(22)
            make.leading.equalTo(emailTextField.snp.leading)
            make.trailing.equalTo(doubleCheckButton.snp.trailing)
        }
    }
    
    private func setupAdditionalLayout() {
        addSubviews([emailMessageLabel, emailButton, idCountLabel])
        
        emailMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(40)
        }
        
        emailButton.snp.makeConstraints { make in
            make.centerY.equalTo(emailTextField.snp.centerY)
            make.trailing.equalTo(emailTextField.snp.trailing)
            make.width.height.equalTo(48)
        }
        
        idCountLabel.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(8)
            make.trailing.equalToSuperview().inset(29)
        }
    }
    
    private func configUI() {
        emailTextField.delegate = self
        emailTextField.setRightPaddingPoints(48)
        
        idTextField.delegate = self
        passwordTextField.delegate = self
        checkPasswordTextField.delegate = self
        
        emailLabel.text = "이메일 주소"
        emailLabel.font = .systemFont(ofSize: 18, weight: .medium)
        
        idLabel.text = "아이디(닉네임)"
        idLabel.font = .systemFont(ofSize: 18, weight: .medium)
        
        passwordLabel.text = "비밀번호"
        passwordLabel.font = .systemFont(ofSize: 18, weight: .medium)
        
        checkPasswordLabel.text = "비밀번호 확인"
        checkPasswordLabel.font = .systemFont(ofSize: 18, weight: .medium)
        
        doubleCheckButton.setTitle("확인", for: .normal)
        doubleCheckButton.setTitleColor(.white, for: .normal)
        doubleCheckButton.titleLabel?.font = .systemFont(ofSize: 14)
        doubleCheckButton.backgroundColor = .gray50
        doubleCheckButton.layer.cornerRadius = 13
        doubleCheckButton.isEnabled = false
        
        emailMessageLabel.text = "중복을 확인해주세요."
        emailMessageLabel.font = .systemFont(ofSize: 12)
        emailMessageLabel.textColor = .pink210
        emailMessageLabel.isHidden = true
        
        emailButton.backgroundColor = .gray
        emailButton.isHidden = true
        
        idCountLabel.text = "0/10"
        idCountLabel.font = .systemFont(ofSize: 14)
        idCountLabel.textAlignment = .right
        idCountLabel.textColor = .gray50
        idCountLabel.isHidden = true
    }
    
    private func setupButtonAction() {
        let checkAction = UIAction { _ in
            self.checkEmailTextFieldUI()
        }
        doubleCheckButton.addAction(checkAction, for: .touchUpInside)
        
        let emailAction = UIAction { _ in
            self.emailTextField.text = ""
        }
        emailButton.addAction(emailAction, for: .touchUpInside)
    }
    
    private func changeTextFields() {
        idTextField.addTarget(self, action: #selector(textDidChanged(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(changePWTextFieldUI), for: .allEditingEvents)
        checkPasswordTextField.addTarget(self, action: #selector(checkPWTextfieldUI), for: .allEditingEvents)
    }
}

// MARK: - UITextFieldDelegate
extension SignupTextFieldView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case emailTextField:
            emailTextField.setupPinkLine()
            
            if doubleCheck {
                emailButton.isHidden = false
                emailButton.isEnabled = false
                emailButton.backgroundColor = .blue100
            } else {
                emailMessageLabel.isHidden = false
                emailMessageLabel.text = "중복을 확인해주세요."
                emailMessageLabel.textColor = .pink210
                
                emailButton.isHidden = false
                emailButton.isEnabled = true
                emailButton.backgroundColor = .gray
            }
            
            doubleCheckButton.isEnabled = true
            doubleCheckButton.backgroundColor = .pink100
        case idTextField:
            idCountLabel.isHidden = false
            
            idTextField.setupPinkLine()
        case passwordTextField:
            passwordTextField.setupPinkLine()
            
            moveTextFieldView()
        case checkPasswordTextField:
            checkPasswordTextField.setupPinkLine()
            
            moveTextFieldView()
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case emailTextField:
            emailTextField.setupOriginalLine()
            
            emailMessageLabel.isHidden = true
            emailButton.isHidden = true
            emailButton.isEnabled = false
            
            doubleCheckButton.isEnabled = false
            doubleCheckButton.backgroundColor = .gray50
        case idTextField:
            idCountLabel.isHidden = true
            
            idTextField.setupOriginalLine()
        case passwordTextField:
            passwordTextField.setupOriginalLine()
            
            backToOriginalView()
        case checkPasswordTextField:
            checkPasswordTextField.setupOriginalLine()
            
            backToOriginalView()
        default:
            break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case emailTextField:
            doubleCheck = false
            
            emailMessageLabel.isHidden = false
            emailMessageLabel.text = "중복을 확인해주세요."
            emailMessageLabel.textColor = .pink210
            
            emailButton.isHidden = false
            emailButton.isEnabled = true
            emailButton.backgroundColor = .gray
            
            return true
        case idTextField:
            /// 이모지 입력 금지
            let utf8Char = string.cString(using: .utf8)
            let isBackSpace = strcmp(utf8Char, "\\b")
            
            if string.hasCharacters() || isBackSpace == -92 {
                return true
            }
            return false
        default:
            return true
        }
    }
}

// MARK: - @Objc
extension SignupTextFieldView {
    @objc
    func changePWTextFieldUI(){
//        if !(pwTextField.text!.validatePassword()) {
//            validatePWLabel.text = "영어와 숫자 조합으로 6자리 이상 입력해 주세요!"
//        }
//        else{
//            if !(pwTextField.text == checkpwTextField.text) {
//                checkPWLabel.text = "비밀번호가 서로 맞지 않아요!"
//                pwCheckLabel.textColor = .mainGray
//            }
//            else{
//                checkPWLabel.text = ""
//                pwCheckLabel.textColor = .mainOrange
//            }
//
//            validatePWLabel.text = ""
//            pwLabel.textColor = .mainOrange
//        }
//        checkValidateUI()
    }
    
    @objc
    func checkPWTextfieldUI(){
//        if !(passwordTextField.text == checkPasswordTextField.text) {
//            checkPWLabel.text = "비밀번호가 서로 맞지 않아요!"
//            pwCheckLabel.textColor = .mainGray
//        }
//        else{
//            checkPWLabel.text = ""
//            pwCheckLabel.textColor = .mainOrange
//        }
        checkValidateUI()
    }
    
    @objc
    func textDidChanged(_ sender: CustomTextField) {
        textCount = sender.text?.count ?? 0
        
        switch textCount {
        case 0:
            idCountLabel.text = "0/10"
            idCountLabel.textColor = .gray200
        case 10:
            let attributedStr = NSMutableAttributedString(string: "10/10")
            attributedStr.addAttribute(.foregroundColor, value: UIColor.red100, range: ("10/10" as NSString).range(of: "10/10"))
            idCountLabel.attributedText = attributedStr
        default:
            let attributedStr = NSMutableAttributedString(string: "\(textCount)/10")
            attributedStr.addAttribute(.foregroundColor, value: UIColor.systemPink, range: ("\(textCount)/10" as NSString).range(of: "\(textCount)"))
            idCountLabel.attributedText = attributedStr
        }
        
        checkMaxLength(textField: sender, maxLength: 10)
    }
}

// MARK: - Helper
extension SignupTextFieldView {
    func checkValidateUI(){
        /// Validate toggle
        if (passwordTextField.text == checkPasswordTextField.text) && (emailTextField.text!.validateEmail()) && (passwordTextField.text!.validatePassword()) && doubleCheck {
            checkValidate = true
        } else {
            checkValidate = false
        }
        
        /// Button isEnable
        if !(idTextField.text!.isEmpty) && !(emailTextField.text!.isEmpty) && !(passwordTextField.text!.isEmpty) && !(passwordTextField.text!.isEmpty) && checkValidate {
            registerButton.isEnabled = true
            registerButton.backgroundColor = .pink100
        } else {
            registerButton.isEnabled = false
            registerButton.backgroundColor = .gray300
        }
    }
    
    func checkEmailTextFieldUI(){
        /// 서버 연결 전이라서 Dummy로 넣어둠
        if !(emailTextField.text!.validateEmail()) || emailTextField.text! != email {
            emailMessageLabel.text = "이메일 주소를 다시 입력해주세요."
            emailMessageLabel.textColor = .red100
            
            emailButton.backgroundColor = .red100
            emailButton.isEnabled = false
            
            doubleCheck = false
        } else {
            emailMessageLabel.text = "중복을 확인해주세요."
            emailMessageLabel.textColor = .pink210
            
            emailButton.backgroundColor = .gray
            emailButton.isEnabled = true
            
            doubleCheck = false
        }
        
        if let text = emailTextField.text,
           text == email {
            emailMessageLabel.text = ""
            
            emailButton.backgroundColor = .blue100
            emailButton.isEnabled = false
            
            doubleCheck = true
            
            checkValidateUI()
        }
    }
    
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (textField.text?.count ?? 0 > maxLength) {
            textField.deleteBackward()
        }
    }
    
    private func moveTextFieldView() {
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.hasNotch ? -268 : -140)
            self.registerButton.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.hasNotch ? -256 : -140)
        })
    }
    
    private func backToOriginalView() {
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = .identity
            self.registerButton.transform = .identity
        })
    }
}
