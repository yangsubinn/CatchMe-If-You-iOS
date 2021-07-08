//
//  CustomTextField.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/08.
//

import UIKit

import SnapKit

class CustomTextField: UITextField {

    init(placeholder: String) {
        super.init(frame: .zero)
        setupLayout()
        configUI(placeholder: placeholder)
        removeAuto()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
    }
    
    private func configUI(placeholder: String) {
        backgroundColor = .black200
        textColor = .white
        
        layer.cornerRadius = 13
        layer.borderWidth = 1
        layer.borderColor = UIColor.clear.cgColor
        
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray400])
        font = .systemFont(ofSize: 16, weight: .medium)
        
        setLeftPaddingPoints(17)
    }
    
    private func removeAuto() {
        autocorrectionType = .no
        autocapitalizationType = .none
        spellCheckingType = .no
        textContentType = .none
    }
    
    // MARK: - TextField Action
    func setupOriginalLine() {
        layer.borderColor = UIColor.clear.cgColor
    }
    
    func setupPinkLine() {
        layer.borderColor = UIColor.pink100.cgColor
    }
}
