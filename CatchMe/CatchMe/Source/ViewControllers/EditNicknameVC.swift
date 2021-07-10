//
//  EditNicknameVC.swift
//  CatchMe
//
//  Created by 양수빈 on 2021/07/10.
//

import UIKit

import SnapKit

class EditNicknameVC: UIViewController {
    
    // MARK: - Lazy Properties
    lazy var backButton = BackButton(self)
    
    // MARK: - Properties
    let titleLabel = UILabel()
    let textField = CustomTextField(placeholder: "변경할 닉네임 입력")
    let editButton = BottomButton(title: "변경하기")
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configUI()
    }
    
    // MARK: - Custom Method
    func setupLayout() {
        view.addSubviews([backButton, titleLabel, textField, editButton])
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(55)
            make.leading.equalToSuperview().offset(14)
            make.width.height.equalTo(48)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(37)
            make.leading.equalToSuperview().offset(28)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(28)
            make.width.equalTo(319)
        }
        
        editButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(319)
            make.bottom.equalToSuperview().inset(50)
        }
    }
    
    func configUI() {
        view.backgroundColor = .black100
        
        titleLabel.text = "닉네임 변경"
        titleLabel.textColor = .white
        titleLabel.font = .stringMediumSystemFont(ofSize: 20)
        
        editButton.backgroundColor = .gray300
        editButton.isEnabled = false
    }
}
