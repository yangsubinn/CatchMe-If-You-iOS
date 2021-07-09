//
//  LoginVC.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/09.
//

import UIKit

import SnapKit

class LoginVC: UIViewController {
    // MARK: - Properties
    let logoImageView = UIImageView()
    let emailTextField = CustomTextField(placeholder: "이메일")
    let passwordTextField = CustomTextField(placeholder: "비밀번호")

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configUI()
    }
    
    // MARK: - Custom Method
    private func setupLayout() {
        view.addSubviews([logoImageView, emailTextField, passwordTextField])
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(91)
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(282)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(69)
            make.leading.trailing.equalToSuperview().inset(28)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(36)
            make.leading.trailing.equalTo(emailTextField)
        }
    }
    
    private func configUI() {
        view.backgroundColor = .black100
        logoImageView.backgroundColor = .systemTeal
        
        emailTextField.changePaddingPoints(point: 50)
        passwordTextField.changePaddingPoints(point: 50)
    }
}
