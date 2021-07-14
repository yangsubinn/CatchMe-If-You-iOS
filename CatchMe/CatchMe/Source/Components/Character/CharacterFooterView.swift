//
//  CharacterFooterView.swift
//  CatchMe
//
//  Created by Thisisme Hi on 2021/07/08.
//

import UIKit

import Then
import SnapKit

class CharacterFooterView: UIView {
    // MARK: - Properties
    let lineView = UIView().then {
        $0.backgroundColor = .black200
    }

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setupAutoLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    func configUI() {
        backgroundColor = .black100
    }
        
    private func setupAutoLayout() {
        addSubview(lineView)
        
        lineView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(self.snp.leading).inset(28)
            make.width.equalTo(1)
            make.height.equalTo(112)
        }
    }
}
