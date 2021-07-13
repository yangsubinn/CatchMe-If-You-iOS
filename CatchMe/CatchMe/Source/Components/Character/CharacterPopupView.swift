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
        $0.text = "이 활동을 지울까요?"
        $0.font = .stringBoldSystemFont(ofSize: 18)
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    let popupSubLabel = UILabel().then {
        $0.text = "지우면 되돌릴 수 없어요."
        $0.font = .stringRegularSystemFont(ofSize: 14)
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
        $0.layer.cornerRadius = 21
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray300.cgColor
        $0.addTarget(self, action: #selector(touchupCancelButton(_:)), for: .touchUpInside)
    }
    
    let deleteButton = UIButton().then {
        $0.backgroundColor = .pink100
        $0.titleLabel?.font = .stringMediumSystemFont(ofSize: 14)
        $0.setTitle("지울래요", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 21
        $0.addTarget(self, action: #selector(touchupDeleteButton(_:)), for: .touchUpInside)
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
        addSubviews([popupLabel, popupSubLabel, popupButtonStackView])
        popupButtonStackView.addArrangedSubview(cancelButton)
        popupButtonStackView.addArrangedSubview(deleteButton)
        
        popupLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.snp.top).inset(38)
        }
        
        popupSubLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(popupLabel.snp.bottom).offset(12)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.width.equalTo(108)
            make.height.equalTo(42)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.width.equalTo(108)
            make.height.equalTo(42)
        }
        
        popupButtonStackView.snp.makeConstraints { make in
            make.top.equalTo(popupSubLabel.snp.bottom).offset(29)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - @objc
    @objc func touchupCancelButton(_ sender: UIButton) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    @objc func touchupDeleteButton(_ sender: UIButton) {
    // 삭제를 시키는 코드를 작성해야 합니다.
    }
}



