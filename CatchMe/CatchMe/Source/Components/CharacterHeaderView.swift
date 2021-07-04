//
//  CharacterHeaderView.swift
//  CatchMe
//
//  Created by Thisisme Hi on 2021/07/04.
//

import UIKit

class CharacterHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Property
    
    let lockDateStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4
        $0.alignment = .center
    }
    
    let lockImageView = UIImageView().then {
//        $0.image = UIImage(named: "")
        $0.backgroundColor = .orange
    }
    
    let dateLabel = UILabel().then {
        $0.text = "2021.05.01부터"
        $0.font = .systemFont(ofSize: 15, weight: .regular)
        $0.textAlignment = .left
        $0.textColor = .gray
        
        let attributedString = NSMutableAttributedString(string: $0.text!)
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 12), range: ($0.text! as NSString).range(of: "부터"))
        $0.attributedText = attributedString
    }
    
    let writeButton = UIButton().then {
//        $0.setImage(UIImage(named: ""), for: .normal)
        $0.backgroundColor = .orange
    }
    
    let nameLabel = UILabel().then {
        $0.text = "눈만 뜨면\n암벽등반 생각 뿐인 날다람쥐"
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textAlignment = .left
        $0.textColor = .white
        $0.numberOfLines = 2
    }
        
    // MARK: - configUI() {
    
    func configUI() {
        
        backgroundColor = .black

    }
    
    // MARK: - setupAutoLayout
    
    private func setupAutoLayout() {
                
        addSubviews([lockDateStackView, writeButton, nameLabel])
        
        lockDateStackView.addArrangedSubview(lockImageView)
        lockDateStackView.addArrangedSubview(dateLabel)
        
        lockImageView.snp.makeConstraints { (make) in
            make.width.equalTo(20)
            make.height.equalTo(21)
        }
        
        lockDateStackView.snp.makeConstraints { (make) in
            make.top.equalTo(19)
            make.leading.equalTo(26)
        }
        
        writeButton.snp.makeConstraints { (make) in
            make.top.equalTo(11)
            make.trailing.equalToSuperview().inset(27)
            make.width.equalTo(72)
            make.height.equalTo(48)
        }
            
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(lockDateStackView.snp.bottom).offset(10)
            make.leading.equalTo(28)
            make.trailing.equalToSuperview().inset(121)
        }
            
    }
}
