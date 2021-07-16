//
//  LogoutPopupView.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/14.
//

import UIKit

class LogoutPopupView: UIView {
    // MARK: - Properties
    let titleLabel = UILabel().then {
        $0.text = "로그아웃하시겠습니까?"
        $0.font = .stringBoldSystemFont(ofSize: 16)
        $0.addCharacterSpacing(kernValue: -0.1, paragraphValue: 0)
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    let popupButtonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 16
        $0.alignment = .center
    }
    
    let cancelButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.titleLabel?.font = .stringMediumSystemFont(ofSize: 14)
        $0.titleLabel?.addCharacterSpacing(kernValue: -0.08, paragraphValue: 0)
        $0.setTitle("아니요", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 15
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray300.cgColor
        $0.addTarget(self, action: #selector(touchupCancelButton(_:)), for: .touchUpInside)
    }
    
    let deleteButton = UIButton().then {
        $0.backgroundColor = .pink100
        $0.titleLabel?.font = .stringMediumSystemFont(ofSize: 14)
        $0.titleLabel?.addCharacterSpacing(kernValue: -0.08, paragraphValue: 0)
        $0.setTitle("네", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 15
        $0.addTarget(self, action: #selector(touchupCloseButton(_:)), for: .touchUpInside)
    }
    
    var viewController = UIViewController()

    // MARK: - Lifecycle
    init(vc: UIViewController) {
        super.init(frame: .zero)
        viewController = vc
        configUI()
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    private func configUI() {
        backgroundColor = .black200
        layer.cornerRadius = 18
        
        titleLabel.addPopupCharacterSpacing()
    }
    
    private func setupAutoLayout() {
        addSubviews([titleLabel, popupButtonStackView])
        popupButtonStackView.addArrangedSubview(cancelButton)
        popupButtonStackView.addArrangedSubview(deleteButton)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.snp.top).inset(44)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.width.equalTo(108)
            make.height.equalTo(35)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.width.equalTo(108)
            make.height.equalTo(35)
        }
        
        popupButtonStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(33)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - @objc
    @objc
    func touchupCancelButton(_ sender: UIButton) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func touchupCloseButton(_ sender: UIButton) {
        print("Log out!")
        Login.shared.setLoginOut()
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let root = storyboard.instantiateViewController(identifier: "LoginVC")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = root
        viewController.dismiss(animated: true, completion: nil)
//        self.viewController.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}
