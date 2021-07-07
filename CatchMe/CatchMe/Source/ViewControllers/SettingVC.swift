//
//  SettingVC.swift
//  CatchMe
//
//  Created by 양수빈 on 2021/07/07.
//

import UIKit

import SnapKit

class SettingVC: UIViewController {
    //MARK: - Properties
    lazy var backButton = BackButton(self)
    let titleLabel = UILabel()

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configUI()
    }
    
    //MARK: - Custom Method
    func setupLayout() {
        view.addSubviews([backButton, titleLabel])
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(55)
            make.leading.equalTo(view.snp.leading).offset(14)
            make.width.height.equalTo(48)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(66)
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(backButton.snp.centerY)
        }
    }
    
    func configUI() {
        view.backgroundColor = .black100
        
        backButton.backgroundColor = .blue100
        
        titleLabel.text = "설정"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.stringBoldSystemFont(ofSize: 20)
    }
    
    func setupTableView() {
        
    }

}
