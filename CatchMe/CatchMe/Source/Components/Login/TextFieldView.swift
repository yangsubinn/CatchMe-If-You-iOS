//
//  TextFieldView.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/09.
//

import UIKit

class TextFieldView: UIView {
    // MARK: - Properties
    let emailTextField = CustomTextField(placeholder: "이메일")
    let passwordTextField = CustomTextField(placeholder: "비밀번호")
    let loginButton = BottomButton(title: "로그인")
    let autoButton = UIButton()
    let memberButton = UIButton()
    let autoLabel = UILabel()
    let memberLabel = UILabel()
    
    var isAuto = true

    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        configUI()
        setupButtonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    private func setupLayout() {
        addSubviews([emailTextField, passwordTextField, autoButton,
                     autoLabel, loginButton, memberLabel, memberButton])
        
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
            make.leading.equalTo(memberLabel.snp.trailing).offset(0)
            make.bottom.equalToSuperview()
            make.width.equalTo(76)
            make.height.equalTo(48)
        }
    }
    
    private func configUI() {
        autoButton.backgroundColor = .systemPink
        
        autoLabel.font = .systemFont(ofSize: 15, weight: .light)
        autoLabel.text = "자동 로그인"
        memberLabel.font = .systemFont(ofSize: 14)
        memberLabel.text = "아직회원이 아니신가요?"
        
        memberButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        memberButton.setTitle("회원가입", for: .normal)
        memberButton.drawUnderline()
        
        emailTextField.changePaddingPoints(point: 50)
        emailTextField.setupEmailImage()
        passwordTextField.changePaddingPoints(point: 50)
        passwordTextField.setupPasswordImage()
    }
    
    private func setupButtonAction() {
        let autoAction = UIAction { _ in
            self.autoButton.backgroundColor = self.isAuto ? .gray : .systemPink
            self.isAuto.toggle()
        }
        autoButton.addAction(autoAction, for: .touchUpInside)
    }
}
