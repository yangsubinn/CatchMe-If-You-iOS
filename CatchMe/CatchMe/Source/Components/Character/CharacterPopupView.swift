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
    }
    
    let deleteButton = UIButton().then {
        $0.backgroundColor = .systemPink
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        $0.setTitle("지울래요", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 15
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
    func configUI() {
        backgroundColor = .black200
        layer.cornerRadius = 18
    }
    
    private func setupAutoLayout() {
        addSubviews([popupLabel, popupButtonStackView])
        popupButtonStackView.addArrangedSubview(cancelButton)
        popupButtonStackView.addArrangedSubview(deleteButton)
        
        popupLabel.snp.makeConstraints { make in
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
            make.top.equalTo(popupLabel.snp.bottom).offset(33)
            make.centerX.equalToSuperview()
        }
    }
}



