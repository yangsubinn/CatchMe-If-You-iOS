//
//  AddCatchuPopupVC.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/13.
//

import UIKit

class AddCatchuPopupVC: UIViewController {
    // MARK: - lazy Properties
    lazy var popupView = AddCatchuPopupView(vc: self)

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    // MARK: - Custom Method
    
    private func setupLayout() {
        view.addSubview(popupView)
        
        popupView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).inset(UIScreen.main.bounds.size.height * 0.4)
            make.centerX.equalToSuperview()
            make.width.equalTo(301)
            make.height.equalTo(182)
        }
    }
}
