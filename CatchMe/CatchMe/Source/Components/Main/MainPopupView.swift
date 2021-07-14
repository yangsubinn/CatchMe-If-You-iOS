//
//  MainPopupView.swift
//  CatchMe
//
//  Created by 양수빈 on 2021/07/14.
//

import UIKit

import Then
import SnapKit

class MainPopupView: UIView {
    // MARK: - Properties
    let levelImageView = UIImageView().then {
        $0.image = UIImage(named: "level1")
    }
    
    let noticeLabel = UILabel().then {
        $0.font = .stringMediumSystemFont(ofSize: 16)
        $0.textColor = .white
        $0.text = "캐츄가 성장했어요!"
    }
    
    let characterImageView = UIImageView().then {
        $0.image = Character.purple.getCharacterImage(phase: 1, size: 131)
    }
    
    let nameLabel = UILabel().then {
        $0.font = .catchuRegularSystemFont(ofSize: 20)
        $0.textColor = .white
        $0.text = "자유로이 세상을 떠도는 탐험가"
    }
    
    let okButton = UIButton().then {
        $0.backgroundColor = .pink100
        $0.titleLabel?.font = .stringMediumSystemFont(ofSize: 16)
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 27
    }
    
    var viewController = UIViewController()
    
    init(vc: UIViewController) {
        super.init(frame: .zero)
        viewController = vc
        configUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    private func configUI() {
        addSubviews([levelImageView, noticeLabel, characterImageView,
                     nameLabel, okButton])
        
        backgroundColor = .black200
        layer.cornerRadius = 18
    }
    
    private func setupLayout() {
        levelImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(43)
            make.width.equalTo(78)
            make.height.equalTo(22)
        }
        
        noticeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(levelImageView.snp.bottom).offset(19)
        }
        
        characterImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(noticeLabel.snp.bottom).offset(24)
            make.width.height.equalTo(121)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(characterImageView.snp.bottom).offset(3)
        }
        
        okButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(23)
        }
    }
}
