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
    /// ReportVC에서 서버 연결 후에 nickname 설정해주기(코드 수정 필요)
    let titleView = TitleView(nickname: "집인데 집가고 싶다")
    /// character는 후에 KingFisher로 해야 할 듯
    let characterView = CharacterView(catching: 13, name: "땅보다 시스템에 잔디 심는 정원사", character: Character.blue.getCharacterImage(phase: 2, size: 121))

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
}
