//
//  CharacterUpperView.swift
//  CatchMe
//
//  Created by Thisisme Hi on 2021/07/04.
//

import UIKit

import Then
import SnapKit

class CharacterUpperView: UIView {
    // MARK: - Properties
    let backgroundView = UIView().then {
        $0.backgroundColor = .blue
    }

    let characterImageView = UIImageView().then {
//        $0.image = UIImage(named: "")
        $0.backgroundColor = .orange
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
        clipsToBounds = true
        backgroundColor = .black
    }
    
    private func setupAutoLayout() {
        addSubviews([backgroundView, characterImageView])
                
        backgroundView.snp.makeConstraints { make in
            make.height.width.equalTo(UIScreen.main.bounds.width)
            make.centerX.centerY.equalToSuperview()
        }
        
        characterImageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(158)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(150)
        }
    }
}
