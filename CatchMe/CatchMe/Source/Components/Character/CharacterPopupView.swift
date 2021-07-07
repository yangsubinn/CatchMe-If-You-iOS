//
//  PopupView.swift
//  CatchMe
//
//  Created by Thisisme Hi on 2021/07/07.
//

import UIKit

import Then
import SnapKit

class CharacterPopupView: UIView {
    // MARK: - Properties
    let popupLabel = UILabel().then {
        $0.text = "활동을 지우시겠어요?"
        $0.font = .systemFont(ofSize: 16, weight: .medium)
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
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 15
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray300.cgColor
//        $0.addTarget(self, action: #selector(<#T##@objc method#>), for: .touc)
    }
    
    let okButton = UIButton().then {
        $0.backgroundColor = .systemPink
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        $0.setTitle("지울래요", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 15
    }
    
    let containerView = UIView().then {
        $0.backgroundColor = .black200
        $0.layer.cornerRadius = 18
    }
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        self.frame = UIScreen.main.bounds
        
        addSubview(containerView)
        containerView.addSubviews([popupLabel, popupButtonStackView])
        popupButtonStackView.addArrangedSubview(cancelButton)
        popupButtonStackView.addArrangedSubview(okButton)
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(320)
            make.centerX.equalToSuperview()
            make.width.equalTo(301)
            make.height.equalTo(152)
        }
        
        popupLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(containerView.snp.top).inset(44)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.width.equalTo(108)
            make.height.equalTo(35)
        }
        
        okButton.snp.makeConstraints { make in
            make.width.equalTo(108)
            make.height.equalTo(35)
        }
        
        popupButtonStackView.snp.makeConstraints { make in
            make.top.equalTo(popupLabel.snp.bottom).offset(33)
            make.centerX.equalToSuperview()
        }
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    func setupAutoLayout() {
//        containerView.addSubviews([popupLabel, popupButtonStackView])
//        popupButtonStackView.addArrangedSubview(cancelButton)
//        popupButtonStackView.addArrangedSubview(okButton)
//
//        popupLabel.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(self.snp.top).inset(44)
//        }
//
//        cancelButton.snp.makeConstraints { make in
//            make.width.equalTo(108)
//            make.height.equalTo(35)
//        }
//
//        okButton.snp.makeConstraints { make in
//            make.width.equalTo(108)
//            make.height.equalTo(35)
//        }
//
//        popupButtonStackView.snp.makeConstraints { make in
//            make.top.equalTo(popupLabel.snp.bottom).offset(33)
//            make.centerX.equalToSuperview()
//        }
//    }
    }
    
}
