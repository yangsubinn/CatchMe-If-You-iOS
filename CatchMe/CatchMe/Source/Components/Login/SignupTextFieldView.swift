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
    let idCountLabel = UILabel()
    let pwMessageLabel = UILabel()
    let checkMessageLabel = UILabel()
    let emailButton = UIButton()
    let idButton = UIButton()
    let emailImageView = UIImageView()
    let idImageView = UIImageView()
    let pwImageView = UIImageView()
    let checkImageView = UIImageView()

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
        setupTextFieldAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method(UI)
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
            make.top.equalTo(emailTextField.snp.bottom).offset(UIScreen.main.hasNotch ? 50 : 30)
            make.leading.equalTo(emailLabel.snp.leading)
        }
        
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(idLabel.snp.bottom).offset(12)
            make.leading.equalTo(emailTextField.snp.leading)
            make.trailing.equalTo(doubleCheckButton.snp.trailing)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(UIScreen.main.hasNotch ? 50 : 30)
            make.leading.equalTo(emailTextField.snp.leading)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(12)
            make.leading.equalTo(emailTextField.snp.leading)
            make.trailing.equalTo(doubleCheckButton.snp.trailing)
        }
        
        checkPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(UIScreen.main.hasNotch ? 50 : 30)
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
        addSubviews([emailMessageLabel, emailButton, idCountLabel,
                     idButton, pwMessageLabel, checkMessageLabel,
                     emailImageView, idImageView, pwImageView,
                     checkImageView])
        
        emailMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(40)
        }
        
        emailButton.snp.makeConstraints { make in
            make.centerY.equalTo(emailTextField.snp.centerY)
            make.trailing.equalTo(emailTextField.snp.trailing)
            make.width.height.equalTo(48)
        }
        
        emailImageView.snp.makeConstraints { make in
            make.centerY.equalTo(emailButton.snp.centerY)
            make.trailing.equalTo(emailButton.snp.trailing)
            make.width.height.equalTo(48)
        }
        
        idCountLabel.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(8)
            make.trailing.equalToSuperview().inset(29)
        }
        
        idButton.snp.makeConstraints { make in
            make.centerY.equalTo(idTextField.snp.centerY)
            make.trailing.equalTo(idTextField.snp.trailing)
            make.width.height.equalTo(48)
        }
        
        idImageView.snp.makeConstraints { make in
            make.centerY.equalTo(idTextField.snp.centerY)
            make.trailing.equalTo(idTextField.snp.trailing)
            make.width.height.equalTo(48)
        }
        
        pwMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(40)
        }
        
        pwImageView.snp.makeConstraints { make in
            make.centerY.equalTo(passwordTextField.snp.centerY)
            make.trailing.equalTo(passwordTextField.snp.trailing)
            make.width.height.equalTo(48)
        }
        
        checkMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(checkPasswordTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(40)
        }
        
        checkImageView.snp.makeConstraints { make in
            make.centerY.equalTo(checkPasswordTextField.snp.centerY)
            make.trailing.equalTo(checkPasswordTextField.snp.trailing)
            make.width.height.equalTo(48)
        }
    }
    
    private func configUI() {
        setupLabel()
        setupButton()
        setupImageView()
        setupTextField()
    }
    
    private func setupLabel() {
        emailLabel.text = "이메일 주소"
        emailLabel.font = .stringMediumSystemFont(ofSize: 18)
        
        idLabel.text = "아이디(닉네임)"
        idLabel.font = .stringMediumSystemFont(ofSize: 18)
        
        passwordLabel.text = "비밀번호"
        passwordLabel.font = .stringMediumSystemFont(ofSize: 18)
        
        checkPasswordLabel.text = "비밀번호 확인"
        checkPasswordLabel.font = .stringMediumSystemFont(ofSize: 18)
        
        emailMessageLabel.text = "중복을 확인해주세요."
        emailMessageLabel.font = .stringRegularSystemFont(ofSize: 12)
        emailMessageLabel.textColor = .pink210
        emailMessageLabel.isHidden = true
        
        idCountLabel.text = "0/10"
        idCountLabel.font = .numberRegularSystemFont(ofSize: 14)
        idCountLabel.textAlignment = .right
        idCountLabel.textColor = .gray50
        idCountLabel.isHidden = true
        
        pwMessageLabel.text = "영문, 숫자, 특수문자 포함 8~16자"
        pwMessageLabel.font = .stringRegularSystemFont(ofSize: 12)
        pwMessageLabel.textColor = .pink210
        pwMessageLabel.isHidden = true
        
        checkMessageLabel.text = "비밀번호를 다시 입력해주세요."
        checkMessageLabel.font = .stringRegularSystemFont(ofSize: 12)
        checkMessageLabel.textColor = .pink210
        checkMessageLabel.isHidden = true
    }
    
    private func setupButton() {
        doubleCheckButton.setTitle("확인", for: .normal)
        doubleCheckButton.setTitleColor(.white, for: .normal)
        doubleCheckButton.titleLabel?.font = .stringRegularSystemFont(ofSize: 14)
        doubleCheckButton.backgroundColor = .gray50
        doubleCheckButton.layer.cornerRadius = 13
        doubleCheckButton.isEnabled = false
        
        emailButton.setImage(UIImage(named: "btnRemove"), for: .normal)
        emailButton.isHidden = true
        
        idButton.setImage(UIImage(named: "btnRemove"), for: .normal)
        idButton.isHidden = true
    }
    
    private func setupImageView() {
        emailImageView.isHidden = true
        
        idImageView.isHidden = true
        
        pwImageView.isHidden = true
        
        checkImageView.isHidden = true
    }
    
    private func setupTextField() {
        emailTextField.delegate = self
        emailTextField.setRightPaddingPoints(48)
        emailTextField.tintColor = .pink100
        emailTextField.font = .stringRegularSystemFont(ofSize: 18)
        
        idTextField.delegate = self
        idTextField.setRightPaddingPoints(48)
        idTextField.tintColor = .pink100
        idTextField.font = .stringRegularSystemFont(ofSize: 18)
        
        passwordTextField.delegate = self
        passwordTextField.setRightPaddingPoints(48)
        passwordTextField.tintColor = .pink100
        passwordTextField.font = .stringRegularSystemFont(ofSize: 18)
        passwordTextField.isSecureTextEntry = true
        
        checkPasswordTextField.delegate = self
        checkPasswordTextField.setRightPaddingPoints(48)
        checkPasswordTextField.tintColor = .pink100
        checkPasswordTextField.font = .stringRegularSystemFont(ofSize: 18)
        checkPasswordTextField.isSecureTextEntry = true
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
        
        let idAction = UIAction { _ in
            self.idTextField.text = ""
            self.textCount = 0
            self.idCountLabel.text = "0/10"
            self.idCountLabel.textColor = .gray200
        }
        idButton.addAction(idAction, for: .touchUpInside)
    }
    
    private func setupTextFieldAction() {
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
            
            doubleCheckButton.isEnabled = true
            doubleCheckButton.backgroundColor = .pink100
            
            if doubleCheck {
                emailImageView.isHidden = false
                emailImageView.image = UIImage(named: "icCheck")
                
                emailButton.isHidden = true
            } else {
                emailMessageLabel.isHidden = false
                emailMessageLabel.text = "중복을 확인해주세요."
                emailMessageLabel.textColor = .pink210
                
                emailButton.isHidden = false
                emailButton.setImage(UIImage(named: "btnRemove"), for: .normal)
                
                emailImageView.isHidden = true
            }
        case idTextField:
            idTextField.setupPinkLine()
            
            idCountLabel.isHidden = false
            idButton.isHidden = false
            idImageView.isHidden = true
        case passwordTextField:
            passwordTextField.setupPinkLine()
            moveTextFieldView()
            
            pwMessageLabel.isHidden = false
            pwImageView.isHidden = false
        case checkPasswordTextField:
            checkPasswordTextField.setupPinkLine()
            moveTextFieldView()
            
            checkMessageLabel.isHidden = false
            checkImageView.isHidden = false
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
            emailImageView.isHidden = true
            doubleCheckButton.isEnabled = false
            doubleCheckButton.backgroundColor = .gray50
        case idTextField:
            idTextField.setupOriginalLine()
            
            idCountLabel.isHidden = true
            idButton.isHidden = true
            idImageView.isHidden = true
        case passwordTextField:
            passwordTextField.setupOriginalLine()
            backToOriginalView()
            
            pwMessageLabel.isHidden = true
            pwImageView.isHidden = true
        case checkPasswordTextField:
            checkPasswordTextField.setupOriginalLine()
            backToOriginalView()
            
            checkMessageLabel.isHidden = true
            checkImageView.isHidden = true
        default:
            break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case emailTextField:
            /// email 수정 시 doubleCheck 다시 받기
            doubleCheck = false
            
            emailMessageLabel.isHidden = false
            emailMessageLabel.text = "중복을 확인해주세요."
            emailMessageLabel.textColor = .pink210
            
            emailButton.isHidden = false
            emailButton.setImage(UIImage(named: "btnRemove"), for: .normal)
            
            emailImageView.isHidden = true
            
            checkValidateUI()
            
            return true
        case idTextField:
            /// 이모지 입력 금지
            let utf8Char = string.cString(using: .utf8)
            let isBackSpace = strcmp(utf8Char, "\\b")
            
            if string.hasCharacters() || isBackSpace == -92 {
                checkValidateUI()
                return true
            }
            
            return false
        default:
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            idTextField.becomeFirstResponder()
        case idTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            checkPasswordTextField.becomeFirstResponder()
        default:
            checkPasswordTextField.resignFirstResponder()
        }
        
        return true
    }
}

// MARK: - @objc
extension SignupTextFieldView {
    @objc
    func changePWTextFieldUI(){
        if !(passwordTextField.text!.validatePassword()) && passwordTextField.hasText {
            pwMessageLabel.text = "비밀번호 조합조건이 틀렸습니다."
            pwMessageLabel.textColor = .red100
            pwImageView.image = UIImage(named: "icWarning")
        } else if passwordTextField.hasText {
            pwMessageLabel.text = ""
            pwImageView.image = UIImage(named: "icCheck")
        } else {
            pwMessageLabel.text = "영문, 숫자, 특수문자 포함 8~16자"
            pwMessageLabel.textColor = .pink210
            pwImageView.image = UIImage(named: "")
        }
        
        checkValidateUI()
    }
    
    @objc
    func checkPWTextfieldUI(){
        if !(passwordTextField.text == checkPasswordTextField.text) && checkPasswordTextField.hasText {
            checkMessageLabel.text = "비밀번호가 일치하지 않습니다."
            checkMessageLabel.textColor = .red100
            checkImageView.image = UIImage(named: "icWarning")
        } else if checkPasswordTextField.hasText {
            checkMessageLabel.text = ""
            checkImageView.image = UIImage(named: "icCheck")
        } else {
            checkMessageLabel.text = "비밀번호를 다시 입력해주세요."
            checkMessageLabel.textColor = .pink210
            checkImageView.image = UIImage(named: "")
        }
        
        checkValidateUI()
    }
    
    @objc
    func textDidChanged(_ sender: CustomTextField) {
        textCount = sender.text?.count ?? 0
        
        switch textCount {
        case 0:
            idCountLabel.text = "0/10"
            idCountLabel.textColor = .gray200
            
            idButton.setImage(UIImage(named: "btnRemove"), for: .normal)
            idButton.isHidden = false
            
            idImageView.isHidden = true
        case 10:
            let attributedStr = NSMutableAttributedString(string: "10/10")
            attributedStr.addAttribute(.foregroundColor, value: UIColor.red100, range: ("10/10" as NSString).range(of: "10/10"))
            idCountLabel.attributedText = attributedStr
            
            idImageView.image = UIImage(named: "icWarning")
            idImageView.isHidden = false
            
            idButton.isHidden = true
        default:
            let attributedStr = NSMutableAttributedString(string: "\(textCount)/10")
            attributedStr.addAttribute(.foregroundColor, value: UIColor.systemPink, range: ("\(textCount)/10" as NSString).range(of: "\(textCount)"))
            idCountLabel.attributedText = attributedStr
            
            idButton.setImage(UIImage(named: "btnRemove"), for: .normal)
            idButton.isHidden = false
            
            idImageView.isHidden = true
            
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
        
        /// signup print(must remove)
        print("---- signup 확인 ----")
        print("1. password 일치 확인 : \(passwordTextField.text == checkPasswordTextField.text)")
        print("2. 유효한 이메일 인가 : \(emailTextField.text!.validateEmail())")
        print("3. 유효한 패스워드 인가 : \(passwordTextField.text!.validatePassword())")
        print("4. 중복 확인 : \(doubleCheck)")
    }
    
    func checkEmailTextFieldUI(){
        /// 서버 연결 전이라서 Dummy로 넣어둠
        if !(emailTextField.text!.validateEmail()) || emailTextField.text! != email {
            emailMessageLabel.text = "이메일 주소를 다시 입력해주세요."
            emailMessageLabel.textColor = .red100
            emailButton.isHidden = true
            
            emailImageView.isHidden = false
            emailImageView.image = UIImage(named: "icWarning")
            
            doubleCheck = false
        } else {
            emailMessageLabel.text = "중복을 확인해주세요."
            emailMessageLabel.textColor = .pink210
            emailButton.setImage(UIImage(named: "btnRemove"), for: .normal)
            emailButton.isHidden = false
            
            emailImageView.isHidden = true
            
            doubleCheck = false
        }
        
        if let text = emailTextField.text,
           text == email {
            emailMessageLabel.text = ""
            emailButton.isHidden = true
            emailImageView.image =  UIImage(named: "icCheck")
            emailImageView.isHidden = false
            
            doubleCheck = true
        }
        
        checkValidateUI()
    }
    
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (textField.text?.count ?? 0 > maxLength) {
            textField.deleteBackward()
        }
    }
    
    private func moveTextFieldView() {
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.hasNotch ? -268 : -220)
            self.registerButton.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.hasNotch ? -UIScreen.main.bounds.size.height * 0.32 : -180)
        })
    }
    
    private func backToOriginalView() {
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = .identity
            self.registerButton.transform = .identity
        })
    }
}
