//
//  CustomTextField.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/08.
//

import UIKit

import SnapKit

class CustomTextField: UITextField {

    // MARK: - Life Cycle
    init(placeholder: String) {
        super.init(frame: .zero)
        setupLayout()
        configUI(placeholder: placeholder)
        removeAuto()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    private func setupLayout() {
        self.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
    }
    
    private func configUI(placeholder: String) {
        backgroundColor = .black200
        
        layer.cornerRadius = 13
        layer.borderWidth = 1
        layer.borderColor = UIColor.clear.cgColor
        
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray400])
        textColor = .white
        font = .systemFont(ofSize: 16, weight: .medium)
        setLeftPaddingPoints(17)
    }
    
    private func removeAuto() {
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.spellCheckingType = .no
        self.textContentType = .none
    }
}
