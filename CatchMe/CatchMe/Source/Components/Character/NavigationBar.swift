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
    // MARK: - Properties
    var viewController = UIViewController()
    lazy var backButton = BackButton(viewController)
    
    let editButton = UIButton().then {
        $0.setImage(UIImage(named: "btnProfileEdit"), for: .normal)
        $0.addTarget(self, action: #selector(touchupEditButton), for: .touchUpInside)
    }
    
    var index = 0
    var name = ""
    var level = 0
    
    // MARK: - Lifecycle
    init(vc: UIViewController, index: Int, name: String, level: Int) {
        super.init(frame: .zero)
        viewController = vc
        self.index = index
        self.name = name
        self.level = level
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    func configUI() {
        backgroundColor = .clear
        
        addSubviews([backButton, editButton])
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading).inset(14)
        }
        
        editButton.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.trailing.equalTo(self.snp.trailing).inset(15)
            make.width.height.equalTo(48)
        }
    }
    
    @objc func touchupEditButton() {
        print(#fileID, #function, #line, "")
        let storyboard = UIStoryboard(name: "Character", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "EditCatchuVC") as? EditCatchuVC else { return }
        vc.characterIndex = index
        vc.characterName = name
        vc.characterLevel = level
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
