//
//  EditPasswordVC.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/14.
//

import UIKit

class EditPasswordVC: UIViewController {
    // MARK: - Lazy Properties
    lazy var backButton = BackButton(self)
    lazy var passwordView = CurrentPasswordView(button: editButton)
    lazy var changePasswordView = ChangePasswordView(button: editButton)
    
    // MARK: - Properties
    let editButton = BottomButton(title: "다음")
    
    // MARK: - Server data
    let viewModel = SettingViewModel.shared
    var isNext = false
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configUI()
        setupButtonAction()
    }
    
    // MARK: - Custom Method
    private func setupLayout() {
        view.addSubviews([backButton, editButton, passwordView,
                          changePasswordView])
        
        backButton.snp.makeConstraints { make in
            if UIScreen.main.hasNotch {
                make.top.equalToSuperview().inset(55)
            } else {
                make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            }
            make.leading.equalToSuperview().offset(14)
            make.width.height.equalTo(48)
        }
        
        editButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(28)
            make.bottom.equalToSuperview().inset(50)
        }
        
        passwordView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(UIScreen.main.hasNotch ? 37 : 15)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(255)
        }
        
        changePasswordView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(UIScreen.main.hasNotch ? 37 : 15)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(255)
        }
    }
    
    private func configUI() {
        view.backgroundColor = .black100
        
        editButton.backgroundColor = .gray200
        editButton.isEnabled = false
        
        changePasswordView.isHidden = true
        
        hideKeyboardWhenTappedAround()
    }
    
    private func setupButtonAction() {
        let nextAction = UIAction { _ in
            if !self.isNext {
                if let text = self.passwordView.passwordTextField.text {
                    self.viewModel.dispatchPasswordCheck(password: text, completion: { check in
                        if check == "true" {
                            self.passwordView.checkTextField.resignFirstResponder()
                            
                            self.passwordView.isHidden = true
                            self.changePasswordView.isHidden = false
                            
                            self.editButton.isEnabled = false
                            self.editButton.backgroundColor = .gray300
                            self.editButton.changeBottomButtonTitle(title: "완료")
                            
                            self.isNext = true
                        } else {
                            self.passwordView.currentLabel.text = "비밀번호가 틀렸습니다."
                            self.passwordView.currentLabel.textColor = .red100
                            
                            self.passwordView.currentImageView.image = UIImage(named: "icWarning")
                        }
                    })
                }
            }
        }
        editButton.addAction(nextAction, for: .touchUpInside)
    }
    
    @objc
    override func dismissKeyboard() {
        if !editButton.isTouchInside {
            view.endEditing(true)
        }
    }
}
