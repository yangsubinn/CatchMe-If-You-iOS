//
//  AddActionPopupView.swift
//  CatchMe
//
//  Created by Thisisme Hi on 2021/07/10.
//

import UIKit

import Then
import SnapKit

class AddActionPopupView: UIView {
    // MARK: - Properties
    let vc = AddActionVC()
    let popupLabel = UILabel().then {
        $0.text = "정말로 화면을 나갈까요?"
        $0.font = .stringMediumSystemFont(ofSize: 16)
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
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 15
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray300.cgColor
        $0.addTarget(self, action: #selector(touchupCancelButton(_:)), for: .touchUpInside)
    }
    
    let closeButton = UIButton().then {
        $0.backgroundColor = .pink100
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        $0.setTitle("나갈래요", for: .normal)
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
    }
    
    private func setupAutoLayout() {
        addSubviews([popupLabel, popupButtonStackView])
        popupButtonStackView.addArrangedSubview(cancelButton)
        popupButtonStackView.addArrangedSubview(closeButton)
        
        popupLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.snp.top).inset(44)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.width.equalTo(108)
            make.height.equalTo(35)
        }
        
        closeButton.snp.makeConstraints { make in
            make.width.equalTo(108)
            make.height.equalTo(35)
        }
        
        popupButtonStackView.snp.makeConstraints { make in
            make.top.equalTo(popupLabel.snp.bottom).offset(33)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - @objc
    @objc func touchupCancelButton(_ sender: UIButton) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    @objc func touchupCloseButton(_ sender: UIButton) {
    // 화면 끄고 CharacterVC로 가는 코드를 짜야 합니다.
    }
}
