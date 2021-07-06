//
//  MainCardCVC.swift
//  CatchMe
//
//  Created by 양수빈 on 2021/07/06.
//

import UIKit

class MainCardCVC: UICollectionViewCell {
    static let identifier = "MainCardCVC"
    
    // MARK: - Properties
    let characterBackView = UIView()
    let characterImageView = UIImageView()
    let nameLabel = UILabel()
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
        setupLayout()
    }
    
    // MARK: - Custom Method
    func configUI() {
        self.backgroundColor = .green
        self.layer.cornerRadius = 14
        characterBackView.backgroundColor = .white
        characterImageView.backgroundColor = .yellow
        
        nameLabel.text = "캐치미캐치유캐치미를정말정말좋아하는캐츄"
        nameLabel.textColor = .black
        nameLabel.font = UIFont.catchuRegularSystemFont(ofSize: 14)
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.numberOfLines = 2
    }
    
    func setupLayout() {
        addSubviews([characterBackView, characterImageView, nameLabel])
        
        characterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
//            make.leading.trailing.equalToSuperview().offset(27)
            make.height.width.equalTo(101)
        }
        
        characterBackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
//            make.bottom.equalTo(self.snp.bottom).offset(56)
            make.height.equalTo(144)
        }
        
        nameLabel.snp.makeConstraints { make in
//            make.top.equalTo(characterBackView.snp.bottom)
            make.leading.equalToSuperview().offset(14)
            make.trailing.equalToSuperview().inset(14)
            make.top.equalTo(characterBackView.snp.bottom).offset(10)
        }
    }
}
