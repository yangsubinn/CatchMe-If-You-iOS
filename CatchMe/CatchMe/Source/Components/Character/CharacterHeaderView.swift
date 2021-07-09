//
//  CharacterHeaderView.swift
//  CatchMe
//
//  Created by Thisisme Hi on 2021/07/04.
//

import UIKit

import Then
import SnapKit

class CharacterHeaderView: UIView {
    // MARK: - Properties
    let vc = CharacterVC()
    
    let lockDateStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .center
    }
    
    let lockImageView = UIImageView().then {
//        $0.image = UIImage(named: "")
        $0.backgroundColor = .orange
    }
    
    let dateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .regular)
        $0.textAlignment = .left
        $0.textColor = .gray
    }
    
    let fromLabel = UILabel().then {
        $0.text = "부터"
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textAlignment = .left
        $0.textColor = .gray
    }
    
    let writeButton = UIButton().then {
//        $0.setImage(UIImage(named: ""), for: .normal)
        $0.backgroundColor = .orange
    }
    
    let nameLabel = UILabel().then {
        $0.text = "한둘셋넷다여일여아열\n한둘셋넷다여일여아열"
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textAlignment = .left
        $0.textColor = .white
        $0.numberOfLines = 2
        $0.lineBreakMode = .byWordWrapping
        
        let attributedString = NSMutableAttributedString(string: $0.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        $0.attributedText = attributedString
    }
    
    // MARK: - Lifecycle
    init(date: String = "2021.05.01 ", name: String = "한둘셋넷다여일여아열\n한둘셋넷다여일여아열") {
        super.init(frame: .zero)
        configUI(date: date, name: name)
        setupAutoLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    func configUI(date: String, name: String) {
        backgroundColor = .black
        
        dateLabel.text = date
        nameLabel.text = name
    }
        
    private func setupAutoLayout() {
        addSubviews([lockDateStackView, fromLabel, writeButton, nameLabel])
        lockDateStackView.addArrangedSubview(lockImageView)
        lockDateStackView.addArrangedSubview(dateLabel)
        
        lockImageView.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        lockDateStackView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(19)
            make.leading.equalTo(self.snp.leading).inset(26)
        }
        
        fromLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(23)
            make.leading.equalTo(lockDateStackView.snp.trailing).offset(1)
        }
        
        writeButton.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(11)
            make.trailing.equalToSuperview().inset(28)
            make.width.equalTo(72)
            make.height.equalTo(48)
        }
            
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(lockDateStackView.snp.bottom).offset(10)
            make.leading.equalTo(self.snp.leading).inset(28)
            make.trailing.equalToSuperview().inset(161)
            make.height.lessThanOrEqualTo(58)
        }
    }
}
