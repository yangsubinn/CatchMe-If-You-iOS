//
//  SignupVC.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/10.
//

import UIKit

import SnapKit

class SignupVC: UIViewController {
    // MARK: - Lazy Properties
    lazy var navigationBar = SignupNaviBar(self)
    lazy var textFieldView = SignupTextFieldView(signupButton)
    
    // MARK: - Properties
    let signupButton = BottomButton(title: "가입하기")
    let height = UIApplication.statusBarHeight
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configUI()
    }

    // MARK: - Custom Method
    private func setupLayout() {
        view.addSubviews([navigationBar, textFieldView, signupButton])
        view.bringSubviewToFront(navigationBar)
        
        navigationBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(59 + height)
        }
        
        textFieldView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(UIScreen.main.hasNotch ? 51 : 20)
            make.leading.trailing.equalToSuperview()
        }
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(textFieldView.snp.bottom).offset(UIScreen.main.hasNotch ? 87 : 30)
            make.leading.trailing.equalToSuperview().inset(28)
        }
    }
    
    private func configUI() {
        view.backgroundColor = .black100
        
        signupButton.backgroundColor = .gray300
        signupButton.isEnabled = false
        
        hideKeyboardWhenTappedAround()
    }
    
    @objc
    override func dismissKeyboard() {
        if !textFieldView.doubleCheckButton.isTouchInside && !textFieldView.emailButton.isTouchInside {
            view.endEditing(true)
        }
    }
}
