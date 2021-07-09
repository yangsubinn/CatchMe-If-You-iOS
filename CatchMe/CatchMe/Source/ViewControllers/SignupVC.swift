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
    
    // MARK: - Properties
    let textFieldView = SignupTextFieldView()
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
        view.addSubviews([navigationBar, textFieldView])
        
        navigationBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.hasNotch ? 59 + height : 59)
        }
        
        textFieldView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(51)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func configUI() {
        view.backgroundColor = .black100
    }
}
