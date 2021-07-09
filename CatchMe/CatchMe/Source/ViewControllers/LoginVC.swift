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
    let textFieldView = TextFieldView()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configUI()
    }
    
    // MARK: - Custom Method
    private func setupLayout() {
        view.addSubviews([logoImageView, textFieldView])
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(135)
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(282)
        }
        
        textFieldView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(69)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func configUI() {
        view.backgroundColor = .black100
        logoImageView.backgroundColor = .systemTeal
    }
}
