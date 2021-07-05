//
//  CharacterUpperView.swift
//  CatchMe
//
//  Created by Thisisme Hi on 2021/07/04.
//

import UIKit

class CharacterUpperView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Property
    let backgroundView = UIView().then {
        $0.backgroundColor = .blue
    }

    let characterImageView = UIImageView().then {
//        $0.image = UIImage(named: "")
        $0.backgroundColor = .orange
        
    }

    // MARK: - Custom Method
    func configUI() {
        
        clipsToBounds = true
        backgroundColor = .black

    }
    
    // MARK: - setupAutoLayout
    
    private func setupAutoLayout() {
    
        addSubviews([backgroundView, characterImageView])
                
        backgroundView.snp.makeConstraints { (make) in
            make.height.width.equalTo(UIScreen.main.bounds.width)
            make.centerX.centerY.equalToSuperview()
        }
        
        characterImageView.snp.makeConstraints { (make) in
            make.top.equalTo(158)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(150)
        }
        
    }

}
