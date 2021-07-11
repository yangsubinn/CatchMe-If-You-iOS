//
//  LookVC.swift
//  CatchMe
//
//  Created by 양수빈 on 2021/07/12.
//

import UIKit

import SnapKit

class LookVC: UIViewController {
    //MARK: - Properties
    lazy var backButton = BackButton(self)
    let titleLabel = UILabel()
    let subLabel = UILabel()
    let topImageView = UIImageView()
    let topBackView  = UIView()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configUI()
    }
    
    //MARK: - Custom Method
    func setupLayout() {
        view.addSubviews([topBackView, backButton, titleLabel, subLabel, topImageView])
        
        topBackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(subLabel.snp.bottom).offset(47)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(UIScreen.main.hasNotch ? 11 : 20)
            make.leading.equalToSuperview().offset(14)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(UIScreen.main.hasNotch ? 28 : 24)
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(UIScreen.main.hasNotch ? 28 : 24)
        }
        
        topImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(UIScreen.main.hasNotch ? 84 : 90)
            make.trailing.equalToSuperview().inset(18)
            make.width.equalTo(82)
            make.height.equalTo(64)
        }
    }
    
    func configUI() {
        view.backgroundColor = .black100
        topBackView.backgroundColor = .brown
        topImageView.backgroundColor = .yellow
        
        titleLabel.text = "다른 유저들의 캐츄"
        titleLabel.textColor = .white
        titleLabel.font = .stringBoldSystemFont(ofSize: 22)
        
        subLabel.text = "블라너ㅓ미허ㅣ머ㅏ미"
        subLabel.textColor = .white
        subLabel.font = .stringMediumSystemFont(ofSize: 14)
    }
}
