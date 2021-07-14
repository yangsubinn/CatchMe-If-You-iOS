//
//  ReportView.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/04.
//

import UIKit

import SnapKit

class ReportView: UIView {
    // MARK: - Properties
    /// UserDefault로 가져오기
    let titleView = TitleView(nickname: "집인데 집가고 싶다")
    var characterView = CharacterView()
    
    var isEmpty: Bool?

    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Methods
    private func setupLayout() {
        addSubviews([titleView, characterView])
        
        characterView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(UIScreen.main.hasNotch ? 31 : 21)
            make.leading.trailing.equalToSuperview().inset(UIScreen.main.hasNotch ? 28 : 20)
            make.height.equalTo(136)
        }
        
        titleView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(UIScreen.main.hasNotch ? 28 : 20)
            make.bottom.equalToSuperview().inset(UIScreen.main.hasNotch ? 188 : 172)
            make.height.equalTo(52)
        }
    }
    
    private func configUI() {
        backgroundColor = .pink100
        layer.cornerRadius = 28
    }
    
    func setCharacterView(data: ReportData?) {
        if let data = data {
            let character = setCharacterImage(level: data.characterLevel, index: data.characterImageIndex, size: 121)
            characterView.setupCharacterView(catching: data.catching, name: data.characterName, character: character)
            
        } else {
            characterView.setupEmptyView()
        }
    }
}
