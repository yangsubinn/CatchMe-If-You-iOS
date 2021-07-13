//
//  AddCatchuPopupView.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/13.
//

import UIKit

import Then
import SnapKit

class AddCatchuPopupView: UIView {
    // MARK: - Properties
    let titleLabel = UILabel().then {
        $0.text = "캐츄 잡기를 멈추고 나갈까요?"
        $0.font = .stringBoldSystemFont(ofSize: 16)
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    let subTitleLabel = UILabel().then {
        $0.text = "나가면 되돌릴 수 없어요."
        $0.addCharacterSpacing(kernValue: -0.08, paragraphValue: 0)
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
        $0.titleLabel?.addCharacterSpacing(kernValue: -0.08, paragraphValue: 0)
        $0.setTitle("아니요", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 21
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray300.cgColor
        $0.addTarget(self, action: #selector(touchupCancelButton(_:)), for: .touchUpInside)
    }
    
    let deleteButton = UIButton().then {
        $0.backgroundColor = .pink100
        $0.titleLabel?.font = .stringMediumSystemFont(ofSize: 14)
        $0.titleLabel?.addCharacterSpacing(kernValue: -0.08, paragraphValue: 0)
        $0.setTitle("나갈래요", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 21
        $0.addTarget(self, action: #selector(touchupCancelButton(_:)), for: .touchUpInside)
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
        addSubviews([titleLabel, subTitleLabel, popupButtonStackView])
        popupButtonStackView.addArrangedSubview(cancelButton)
        popupButtonStackView.addArrangedSubview(deleteButton)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.snp.top).inset(38)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
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
            make.top.equalTo(subTitleLabel.snp.bottom).offset(29)
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
        viewController.dismiss(animated: true, completion: nil)
    }
}
