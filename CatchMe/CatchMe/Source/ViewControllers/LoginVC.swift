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

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configUI()
    }
    
    // MARK: - Custom Method
    private func setupLayout() {
        view.addSubviews([logoImageView, ])
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(91)
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(282)
        }
    }
    
    private func configUI() {
        logoImageView.backgroundColor = .systemTeal
    }
}
