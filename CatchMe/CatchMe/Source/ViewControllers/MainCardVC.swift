//
//  MainCardVC.swift
//  CatchMe
//
//  Created by 양수빈 on 2021/07/06.
//

import UIKit

import SnapKit

class MainCardVC: UIViewController {
    //MARK: - Properties
    lazy var backButton = BackButton(self)
    let nameLabel = UILabel()
    let vcTitleLabel = UILabel()
    let popupButton = UIButton()
    let addButton = UIButton()
    let alignButton = UIButton()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configUI()
    }
    
    //MARK: - Custom Method
    func setupLayout() {
        view.addSubviews([backButton, nameLabel, vcTitleLabel, popupButton, addButton, alignButton])
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(55)
            make.leading.equalTo(view.snp.leading).offset(14)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(16)
            make.leading.equalTo(view.snp.leading).offset(28)
        }
        
        vcTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(6)
            make.leading.equalTo(view.snp.leading).offset(28)
        }
        
        popupButton.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.leading.equalTo(vcTitleLabel.snp.trailing)
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
        }
        
        addButton.snp.makeConstraints { make in
            make.width.equalTo(72)
            make.height.equalTo(48)
            make.trailing.equalTo(view.snp.trailing).inset(27)
            make.top.equalTo(backButton.snp.bottom).offset(14)
        }
        
        alignButton.snp.makeConstraints { make in
            make.width.height.equalTo(48)
            make.trailing.equalTo(view.snp.trailing).inset(13)
            make.top.equalTo(addButton.snp.bottom).offset(27)
        }
    }
    
    func configUI() {
        view.backgroundColor = .black100
        
        nameLabel.text = "최고의대장피엠김해리 님"
        nameLabel.textColor = .white
        nameLabel.font = UIFont.stringBoldSystemFont(ofSize: 14)
        
        vcTitleLabel.text = "캐츄 모아보기"
        vcTitleLabel.textColor = .white
        vcTitleLabel.font = UIFont.stringBoldSystemFont(ofSize: 22)
        
        popupButton.backgroundColor = .blue
        addButton.backgroundColor = .yellow
        alignButton.backgroundColor = .gray300
    }
}
