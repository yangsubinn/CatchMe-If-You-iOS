//
//  CharacterCVC.swift
//  CatchMe
//
//  Created by 양수빈 on 2021/07/04.
//

import UIKit

class CharacterCVC: UICollectionViewCell {
    static let identifier = "CharacterCVC"
    
    //MARK: - Properties
    let characterImageView = UIImageView()
    let reportView = mainReportView()
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
        setupLayout()
        setupReportView()
    }
    
    //MARK: - Custom Method
    func configUI() {
        characterImageView.image = Character.purple.getCharacterImage(phase: 3, size: 181)
        self.backgroundColor = .clear
    }
    
    func setupLayout() {
        addSubviews([reportView, characterImageView])
        
        characterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIScreen.main.hasNotch ? 44 : 18)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(181)
        }
        
        reportView.snp.makeConstraints { make in
            make.top.equalTo(characterImageView.snp.bottom).offset(UIScreen.main.hasNotch ? 54 : 24)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(152)
        }
    }
    
    func setupReportView() {
        reportView.backgroundColor = .black200
        reportView.layer.cornerRadius = 14
        reportView.layer.borderColor = UIColor.bordergrey.cgColor
        reportView.layer.borderWidth = 2
    }
}
