//
//  MoreMenuView.swift
//  CatchMe
//
//  Created by Thisisme Hi on 2021/07/06.
//

import UIKit

import Then
import SnapKit

class MoreMenuView: UIView {
    // MARK: - Properties
    let editButton = UIButton().then {
        $0.setImage(UIImage(named: ""), for: .normal)
        $0.backgroundColor = .red
//        $0.addTarget(self, action: #selector(touchupEditButton(_:)), for: .touchUpInside)
    }
    
    lazy var deleteButton = UIButton().then {
        $0.setImage(UIImage(named: ""), for: .normal)
        $0.backgroundColor = .yellow
//        $0.addTarget(self, action: #selector(touchupDeleteButton), for: .touchUpInside)
    }
    
    var vc = UIViewController()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(presentingController: UIViewController) {
        super.init(frame: .zero)
        vc = presentingController
        configUI()
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    func configUI() {
        backgroundColor = .clear
    }
        
    private func setupAutoLayout() {
        addSubviews([editButton, deleteButton])
        
        editButton.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(48)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(editButton.snp.trailing).offset(1)
            make.width.equalTo(50)
            make.height.equalTo(48)
        }
    }
    
    
}
