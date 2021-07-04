//
//  CharacterTVC.swift
//  CatchMe
//
//  Created by Thisisme Hi on 2021/07/04.
//

import UIKit

class CharacterTVC: UITableViewCell {
    
    static let identifier = "CharacterTVC"

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Property
    
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
        $0.addTarget(self, action: #selector(touchupMoreButton), for: .touchUpInside)
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
        paragraphStyle.lineSpacing = 10

        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
                
        $0.attributedText = attributedString
    }
    
    let photoImageView = UIImageView().then {
//        $0.image = UIImage(named: "")
        $0.backgroundColor = .systemPink
        $0.layer.cornerRadius = 18
    }
    
    
    // MARK: - setupAutoLayout
    
    func setupAutoLayout() {
        
        backgroundColor = .black
      
        addSubviews([pinImageView, lineView, dateLabel, commentView, moreButton, photoImageView])
        
        commentView.addSubview(commentLabel)
        
        pinImageView.snp.makeConstraints { (make) in
            make.top.equalTo(38)
            make.leading.equalTo(22)
            make.width.height.equalTo(12)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.top.equalTo(pinImageView.snp.bottom)
            make.leading.equalTo(27.5)
            make.bottom.equalToSuperview().offset(37)
            make.width.equalTo(1)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(pinImageView.snp.trailing).offset(9)
            make.bottom.equalTo(pinImageView.snp.bottom)
        }
        
        moreButton.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.trailing.equalTo(-6)
            make.width.height.equalTo(48)
        }
        
        commentView.snp.makeConstraints { (make) in
            make.top.equalTo(dateLabel.snp.bottom).offset(12)
            make.leading.equalTo(lineView.snp.trailing).offset(15.5)
            make.bottom.equalTo(-5)
            make.trailing.equalToSuperview().offset(-28)
            make.width.equalTo(275)
            make.height.equalTo(18)
            
        }
        
        commentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(12)
            make.leading.equalTo(14)
            make.trailing.equalTo(-14)
            make.bottom.equalTo(-12)
        }
        
        photoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(commentView.snp.bottom).offset(16)
            make.leading.equalTo(lineView.snp.trailing).offset(15.5)
            make.bottom.equalTo(-5)
            make.trailing.equalTo(-28)
        }
        
    }
    
    // MARK: - Helpers

    @objc func touchupMoreButton() {
        
    }
    
    func setData(date: String, comment: String, image: String) {
        
        dateLabel.text = date
        commentLabel.text = comment
        
        if image == image {
            photoImageView.image = UIImage(named: image)
        }
        
    }

}
