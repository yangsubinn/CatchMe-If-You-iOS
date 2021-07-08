//
//  ThirdFlowView.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/08.
//

import UIKit

import SnapKit

class ThirdFlowView: UIView {
    // MARK: - Properties
    let titleView = CatchuTitleView(title: "새로운 캐츄가 태어났어요!", subTitle: "내 안에 방금 생겨난 캐츄를 확인하세요")
    let characterImageView = UIImageView()
    let backgroundImageView = UIImageView()
    let nameLabel = UILabel()
    let lockLabel = UILabel()
    let lockButton = UIButton()
    
    var textCount = 0
    var isLock = false
    
    // MARK: - Dummy Data
    /// 후에 enum으로 사용하면 편리할 듯 -> 아니면 public하게 전체적으로 사용할 수 있도록 만들기
    let colors: [UIColor] = [.systemRed, .systemBlue, .systemPink, .systemTeal, .systemGray, .systemGreen, .systemOrange, .systemYellow, .systemPurple, .systemIndigo]

    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        configUI()
        setupButtonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Methods
    private func setupLayout() {
        addSubviews([titleView, backgroundImageView, characterImageView,
                     nameLabel, lockLabel, lockButton])
        
        titleView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(28)
        }
        
        characterImageView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(UIScreen.main.hasNotch ? 175 : 115)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(150)
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.bottom.equalTo(characterImageView.snp.bottom).offset(1)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(181)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(characterImageView.snp.bottom).offset(39)
            make.centerX.equalToSuperview()
            make.width.equalTo(190)
        }
        
        lockButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(22)
            make.bottom.equalToSuperview().inset(14)
            make.width.height.equalTo(34)
        }
        
        lockLabel.snp.makeConstraints { make in
            make.leading.equalTo(lockButton.snp.trailing).offset(8)
            make.centerY.equalTo(lockButton.snp.centerY)
        }
    }
    
    private func configUI() {
        backgroundImageView.backgroundColor = .white
        
        nameLabel.numberOfLines = 2
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.textColor = .white
        nameLabel.textAlignment = .center
        nameLabel.font = .systemFont(ofSize: 22, weight: .black)
        
        lockButton.backgroundColor = .systemPink
        
        lockLabel.text = "다른 사용자에게 공개할래요"
        lockLabel.font = .systemFont(ofSize: 14)
        lockLabel.textColor = .white
    }
    
    private func setupButtonAction() {
        let lockAction = UIAction { _ in
            self.lockButton.backgroundColor = self.isLock ? .systemPink : .gray
            self.isLock.toggle()
        }
        lockButton.addAction(lockAction, for: .touchUpInside)
    }
    
    // MARK: - external use function
    /// asset 넣기 전까지 dummy Color
    func setImageViewColor(selectedIndex: Int) {
        characterImageView.backgroundColor = colors[selectedIndex]
    }
    
    func setCharacterName(name: String) {
        nameLabel.text = name
    }
}
