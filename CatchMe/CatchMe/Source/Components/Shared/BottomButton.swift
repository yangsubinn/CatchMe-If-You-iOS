//
//  BottomButton.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/02.
//

import UIKit

class BottomButton: UIButton {

    init(title: String) {
        super.init(frame: .zero)
        configUI(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Extension Color, Font들어오면 바꿀 예정
    private func configUI(title: String) {
        backgroundColor = .systemPink
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .boldSystemFont(ofSize: 18)
    }
    
    // MARK: - BottomButton Action
}
