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
    
    // MARK: - Properties
    let editButton = BottomButton(title: "완료")
    let passwordView = CurrentPasswordView()
    
    // MARK: - Dummy Data
    var currentNickname = "@야@꿍@이@"
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configUI()
    }
    
    // MARK: - Custom Method
    func setupLayout() {
        view.addSubviews([backButton, editButton, passwordView])
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(55)
            make.leading.equalToSuperview().offset(14)
            make.width.height.equalTo(48)
        }
        
        editButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(319)
            make.bottom.equalToSuperview().inset(50)
        }
        
        passwordView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(37)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(255)
        }
    }
    
    func configUI() {
        view.backgroundColor = .black100
        
        editButton.backgroundColor = .gray200
        editButton.isEnabled = false
        
        hideKeyboardWhenTappedAround()
    }
    
    @objc
    override func dismissKeyboard() {
        view.endEditing(true)
    }
}
