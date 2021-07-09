//
//  CustomTextField.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/08.
//

import UIKit

import Then
import SnapKit

class CustomTextField: UITextField {
    let emailImageView = UIImageView().then {
        $0.backgroundColor = .gray
    }
    
    let passwordImageView = UIImageView().then {
        $0.backgroundColor = .gray
    }

    init(placeholder: String, isAddCatchu: Bool? = false) {
        super.init(frame: .zero)
        setupLayout(isAddCatchu ?? false)
        configUI(placeholder: placeholder, isAddCatchu ?? false)
        removeAuto()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(_ isAddCatchu: Bool) {
        self.snp.makeConstraints { make in
            make.height.equalTo(isAddCatchu ? 48 : 56)
        }
    }
    
    private func configUI(placeholder: String, _ isAddCatchu: Bool = false) {
        backgroundColor = .black200
        textColor = .white
        
        layer.cornerRadius = isAddCatchu ? 13 : 20
        layer.borderWidth = 1
        layer.borderColor = UIColor.clear.cgColor
        
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : isAddCatchu ? UIColor.gray400 : UIColor.gray100])
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
    
    func changePaddingPoints(point: CGFloat) {
        setLeftPaddingPoints(point)
    }
    
    func setupEmailImage() {
        addSubview(emailImageView)
        
        emailImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(22)
            make.height.width.equalTo(18)
        }
    }
    
    func setupPasswordImage() {
        isSecureTextEntry = true
        
        addSubviews([passwordImageView])
        
        passwordImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(22)
            make.height.width.equalTo(18)
        }
    }
}
