//
//  WithdrawalVC.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/14.
//

import UIKit

class WithdrawalVC: UIViewController {
    // MARK: - Lazy Properties
    lazy var backButton = BackButton(self)
    
    // MARK: - Properties
    let titleLabel = UILabel()
    let agreeButton = UIButton()
    let agreeLabel = UILabel()
    let editButton = BottomButton(title: "탈퇴하기")
    
    var isAgree = false
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configUI()
    }
    
    // MARK: - Custom Method
    func setupLayout() {
        view.addSubviews([backButton, titleLabel, agreeLabel,
                          agreeButton, editButton])
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(55)
            make.leading.equalToSuperview().offset(14)
            make.width.height.equalTo(48)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(37)
            make.leading.equalToSuperview().offset(28)
        }
        
        editButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(28)
            make.bottom.equalToSuperview().inset(50)
        }
        
        agreeButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(22)
            make.bottom.equalTo(editButton.snp.top).offset(-14)
            make.width.height.equalTo(34)
        }
        
        agreeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(agreeButton.snp.centerY)
            make.leading.equalTo(agreeButton.snp.trailing).offset(5)
        }
    }
    
    func configUI() {
        view.backgroundColor = .black100
        
        titleLabel.text = "정말 탈퇴하시겠어요?"
        titleLabel.textColor = .white
        titleLabel.font = .stringMediumSystemFont(ofSize: 20)
        titleLabel.addCharacterSpacing()
        
        editButton.backgroundColor = .gray200
        editButton.isEnabled = false
        editButton.addTarget(self, action: #selector(touchupEditButton), for: .touchUpInside)

        agreeButton.setImage(UIImage(named: "checkboxInactive"), for: .normal)
        agreeButton.addTarget(self, action: #selector(touchupAgree), for: .touchUpInside)
        
        agreeLabel.text = "동의합니다."
        agreeLabel.font = .stringRegularSystemFont(ofSize: 15)
        agreeLabel.addCharacterSpacing()
        agreeLabel.textColor = .gray400
    }
    
    @objc
    func touchupAgree() {
        if !isAgree {
            agreeButton.setImage(UIImage(named: "checkboxActive"), for: .normal)
            agreeLabel.textColor = .white

            editButton.backgroundColor = .pink100
            editButton.isEnabled = true
        } else {
            agreeButton.setImage(UIImage(named: "checkboxInactive"), for: .normal)
            agreeLabel.textColor = .white

            editButton.backgroundColor = .gray200
            editButton.isEnabled = false
        }
        
        isAgree.toggle()
    }
    
    @objc
    func touchupEditButton() {
        print("with drawal~")
    }
}
