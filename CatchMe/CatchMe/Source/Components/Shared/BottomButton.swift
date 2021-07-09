//
//  BottomButton.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/02.
//

import UIKit

import SnapKit

class BottomButton: UIButton {

    init(title: String) {
        super.init(frame: .zero)
        setupLayout()
        configUI(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Extension Color, Font들어오면 바꿀 예정
    private func setupLayout() {
        self.snp.makeConstraints { make in
            make.height.equalTo(54)
        }
    }
    
    private func configUI(title: String) {
        backgroundColor = .pink100
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        layer.cornerRadius = 25
    }
    
    // MARK: - BottomButton Action
    func changeBottomButtonTitle(title: String) {
        setTitle(title, for: .normal)
    }
    
    func changeBottomButton(isEnable: Bool?) {
        if !isEnabled {
            isEnabled = false
            backgroundColor = .gray300
        } else {
            isEnabled = true
            backgroundColor = .pink100
        }
    }
    
    func setBottomColor(color: UIColor) {
        backgroundColor = color
    }
}
