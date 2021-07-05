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
    let titleView = TitleView(nickname: "이지님")
    /// character는 후에 KingFisher로 해야 할 듯
    let characterView = CharacterView(catching: 7, name: "자유로이 떠도는 탐험가", character: "")

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
            make.bottom.equalToSuperview().inset(31)
            make.leading.trailing.equalToSuperview().inset(28)
            make.height.equalTo(136)
        }
        
        titleView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(28)
            make.bottom.equalToSuperview().inset(188)
            make.height.equalTo(52)
        }
    }
    
    private func configUI() {
        backgroundColor = .systemPink
        layer.cornerRadius = 20
    }
}
