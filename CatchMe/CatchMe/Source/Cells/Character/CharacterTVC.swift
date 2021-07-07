//
//  CharacterTVC.swift
//  CatchMe
//
//  Created by Thisisme Hi on 2021/07/04.
//

import UIKit

import Then
import SnapKit

class CharacterTVC: UITableViewCell {
    static let identifier = "CharacterTVC"

    // MARK: - Properties
    let pinImageView = UIImageView().then {
//        $0.image = UIImage(named: "icPin")
        $0.backgroundColor = .orange
    }
    
    let lineView = UIView().then {
        $0.backgroundColor = .yellow
    }
    
    let dateLabel = UILabel().then {
        $0.text = "2021.08.01"
        $0.textColor = .gray
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    let moreButton = UIButton().then {
//        $0.setImage(UIImage(named: ""), for: .normal)
        $0.backgroundColor = .green
    }
    
    let moreMenuView = MoreMenuView(presentingController: CharacterPopupVC())
    
    let contentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 16
        $0.alignment = .center
    }
    
    let commentView = UIImageView().then {
//        $0.image = UIImage(named: "icComment")
        $0.backgroundColor = .orange
    }
    
    let commentLabel = UILabel().then {
        $0.text = "암벽을 올랐다. 뿌듯해따 -.-암벽을 올랐다. 뿌듯해따 -.-암벽을 올랐다. 뿌듯해따 -.-암벽을 올랐다. 뿌듯해따 -.-암벽을 올랐다. 뿌듯해따 -.-"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textAlignment = .left
        $0.numberOfLines = 0
        
        let attributedString = NSMutableAttributedString(string: $0.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0.08

        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
                
        $0.attributedText = attributedString
    }
    
    let photoImageView = UIImageView().then {
//        $0.image = UIImage(named: "")
        $0.backgroundColor = .systemPink
        $0.layer.cornerRadius = 18
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.sendSubviewToBack(contentView)
        moreButton.isSelected = true
        moreButton.addTarget(self, action: #selector(touchupMoreButton(_:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Custom Method
    func setupAutoLayout() {
        backgroundColor = .black
      
        addSubviews([pinImageView, lineView, dateLabel, contentStackView, moreButton, moreMenuView])
        commentView.addSubview(commentLabel)
        contentStackView.addArrangedSubview(commentView)
        contentStackView.addArrangedSubview(photoImageView)
        
        pinImageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(38)
            make.leading.equalTo(self.snp.leading).inset(22)
            make.width.height.equalTo(12)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(pinImageView.snp.bottom)
            make.leading.equalTo(self.snp.leading).inset(27.5)
            make.bottom.equalToSuperview().offset(38)
            make.width.equalTo(1)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(pinImageView.snp.trailing).offset(9)
            make.bottom.equalTo(pinImageView.snp.bottom)
        }
        
        moreButton.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(20)
            make.trailing.equalTo(self.snp.trailing).inset(6)
            make.width.height.equalTo(48)
        }
        
        contentStackView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(12)
            make.leading.equalTo(lineView.snp.trailing).offset(15.5)
            make.bottom.equalTo(self.snp.bottom).inset(5)
            make.trailing.equalTo(self.snp.trailing).inset(28)
        }
        
        commentView.snp.makeConstraints { make in
            make.width.equalTo(303)
            make.height.equalTo(42)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(commentView.snp.top).inset(12)
            make.leading.equalTo(commentView.snp.leading).inset(14)
            make.trailing.equalTo(commentView.snp.trailing).inset(14)
            make.bottom.equalTo(commentView.snp.bottom).inset(12)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.width.equalTo(303)
            make.height.equalTo(228)
        }
    }
    
    @objc func touchupMoreButton(_ sender: UIButton) {
        if moreButton.isSelected == false {
            moreButton.isSelected = true
            moreMenuView.isHidden = true
        } else if moreButton.isSelected == true {
            moreButton.isSelected = false
            moreMenuView.isHidden = false
        
            moreMenuView.snp.makeConstraints { make in
                make.top.equalTo(moreButton.snp.top).offset(34)
                make.leading.equalTo(contentStackView.snp.leading).inset(202)
                make.width.equalTo(100)
                make.height.equalTo(48)
            }
        }
    }

    func setData(date: String, comment: String, image: String) {
        dateLabel.text = date
        commentLabel.text = comment
        
        if image == image {
            photoImageView.image = UIImage(named: image)
        }
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        let touch = touches.first
//        if touch?.view != self.moreMenuView {
//            moreMenuView.is
//        }
//    }
}
