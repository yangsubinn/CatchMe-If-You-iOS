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
    let emptyStateImageView = UIImageView().then {
        $0.image = UIImage(named: "imgCharacterViewEmptyState")
    }
    
    let emptyStateLabel = UILabel().then {
        $0.text = "아직 캐츄의 활동이 없어요"
        $0.font = .stringRegularSystemFont(ofSize: 18)
        $0.textColor = .gray200
        $0.textAlignment = .center
    }
    
    let pinImageView = UIImageView().then {
        $0.image = UIImage(named: "ic")
    }
    
    let lineTopView = UIView().then {
        $0.backgroundColor = .black200
    }
    
    let lineView = UIView().then {
        $0.backgroundColor = .black200
    }
    
    let dateLabel = UILabel().then {
        $0.text = "2021.08.01"
        $0.textColor = .gray310
        $0.font = .numberRegularSystemFont(ofSize: 14)
        $0.textAlignment = .left
    }
    
    let moreButton = UIButton().then {
        $0.setImage(UIImage(named: "btnMore"), for: .normal)
    }
    
    let contentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 16
        $0.alignment = .center
    }
    
    let commentView = UIImageView().then {
        $0.image = UIImage(named: "icCommentRectangle")
    }
    
    let commentLabel = UILabel().then {
        $0.text = "암벽을 올랐다. 뿌듯해따 -.-암벽을 올랐다. 뿌듯해따 -.-암벽을 올랐다. 뿌듯해따 -.-암벽을 올랐다. 뿌듯해따 -.-암벽을 올랐다. 뿌듯해따 -.-"
        $0.textColor = .white
        $0.font = .stringRegularSystemFont(ofSize: 14)
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.addCharacterSpacing(kernValue: -0.08, paragraphValue: 2)
    }
    
    let photoImageView = UIImageView().then {
        $0.image = UIImage(named: "imgActivityPhoto")
        $0.layer.cornerRadius = 18
        $0.contentMode = .scaleAspectFill
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Custom Method
    func configUI() {
        backgroundColor = .black100
        self.sendSubviewToBack(contentView)
    }
    
    func setupAutoLayout() {
        addSubviews([lineTopView, lineView, pinImageView,
                     dateLabel, contentStackView, moreButton])
        commentView.addSubview(commentLabel)
        contentStackView.addArrangedSubview(commentView)
        contentStackView.addArrangedSubview(photoImageView)
        
        lineTopView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(self.snp.leading).inset(28)
            make.bottom.equalTo(pinImageView.snp.top)
            make.width.equalTo(1)
        }
        
        pinImageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(36)
            make.leading.equalTo(self.snp.leading).inset(22)
            make.width.height.equalTo(12)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(pinImageView.snp.bottom).inset(1)
            make.leading.equalTo(self.snp.leading).inset(28)
            make.bottom.equalToSuperview()
            make.width.equalTo(1)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(pinImageView.snp.trailing).offset(9)
            make.bottom.equalTo(pinImageView.snp.bottom).offset(2)
        }
        
        moreButton.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(20)
            make.trailing.equalTo(self.snp.trailing).inset(6)
            make.width.height.equalTo(48)
        }
        
        contentStackView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(12)
            make.leading.equalTo(lineView.snp.trailing).offset(16)
            make.bottom.equalTo(self.snp.bottom).inset(5)
            make.trailing.equalTo(self.snp.trailing).inset(28)
        }
        
        commentView.snp.makeConstraints { make in
            make.width.equalTo(303)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(12)
            make.leading.equalTo(14)
            make.trailing.equalTo(-14)
            make.bottom.equalTo(-12)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.width.equalTo(303)
            make.height.equalTo(228)
        }
    }

    func setupEmptyLayout() {
        addSubviews([emptyStateImageView, emptyStateLabel])
        
        emptyStateImageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(25)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.hasNotch ? 251 : 0)
            make.height.equalTo(UIScreen.main.hasNotch ? 145 : 0)
        }
        
        emptyStateLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyStateImageView.snp.bottom).offset(UIScreen.main.hasNotch ? 0 : 10)
            make.centerX.equalToSuperview()
        }
    }
    
    func setData(date: String, comment: String, image: String) {
        dateLabel.text = date
        commentLabel.text = comment
        
        if let image = UIImage(named: image) {
            photoImageView.image = image
        }
    }
}
