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
    let babyCatchus: [UIImage?] = [Character.blue.getCharacterImage(phase: 1, size: 151), Character.green.getCharacterImage(phase: 1, size: 151), Character.orange.getCharacterImage(phase: 1, size: 151), Character.purple.getCharacterImage(phase: 1, size: 151), Character.yellowGreen.getCharacterImage(phase: 1, size: 151)]

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
            make.height.width.equalTo(151)
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.bottom.equalTo(characterImageView.snp.bottom).offset(1)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(181)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(characterImageView.snp.bottom).offset(39)
            make.centerX.equalToSuperview()
            make.width.equalTo(169)
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
        nameLabel.textColor = .white
        nameLabel.font = .catchuRegularSystemFont(ofSize: 22)
        
        lockButton.setImage(UIImage(named: "checkboxActive"), for: .normal)
        
        lockLabel.text = "다른 사용자에게 공개할래요"
        lockLabel.font = .stringRegularSystemFont(ofSize: 14)
        lockLabel.addCharacterSpacing()
        lockLabel.textColor = .white
    }
    
    private func setupButtonAction() {
        let lockAction = UIAction { _ in
            self.lockButton.setImage(self.isLock ? UIImage(named: "checkboxActive") : UIImage(named: "checkboxInactive"), for: .normal)
            self.lockLabel.textColor = self.isLock ? .white : .gray400
            self.isLock.toggle()
        }
        lockButton.addAction(lockAction, for: .touchUpInside)
    }
    
    // MARK: - external use function
    func setImageViewColor(selectedIndex: Int) {
        characterImageView.image = babyCatchus[selectedIndex]
    }
    
    func setCharacterName(name: String) {
        nameLabel.text = name
        nameLabel.addCharacterSpacing(kernValue: -0.6, paragraphValue: 6)
        nameLabel.textAlignment = .center
    }
}
