//
//  NavigationBar.swift
//  CatchMe
//
//  Created by Thisisme Hi on 2021/07/04.
//

import UIKit

import Then
import SnapKit

class NavigationBar: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Property
    
    let backButton = BackButton(MainVC())
    
    let editButton = UIButton().then {
//        $0.setImage(UIImage(named: "btnWrite"), for: .normal)
        $0.addTarget(self, action: #selector(touchupEditButton), for: .touchUpInside)
        $0.backgroundColor = .orange
    }
    
    // MARK: - configUI()
    
    func configUI() {
        backgroundColor = .clear
        
        addSubviews([backButton, editButton])
        
        backButton.snp.makeConstraints { (make) in
            make.top.equalTo(55)
            make.leading.equalTo(14)
        }
        
        editButton.snp.makeConstraints { (make) in
            make.top.equalTo(55)
            make.trailing.equalTo(-15)
            make.width.height.equalTo(48)
        }
        
    }
    
    @objc func touchupEditButton() {
        
    }
    
}
