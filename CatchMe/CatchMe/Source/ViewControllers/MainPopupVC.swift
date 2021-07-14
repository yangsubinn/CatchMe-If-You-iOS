//
//  MainPopupVC.swift
//  CatchMe
//
//  Created by 양수빈 on 2021/07/14.
//

import UIKit

import SnapKit

class MainPopupVC: UIViewController {
    // MARK: - Lazy Properties
    lazy var popupView = MainPopupView(vc: self)
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
    }
    
    // MARK: - Custom Method
    private func configUI() {
        view.backgroundColor = .black200
    }
    
    private func setupLayout() {
        view.addSubview(popupView)
        
        let height = UIScreen.main.bounds.size.height / 667
        
        popupView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(UIScreen.main.bounds.size.height * 0.2)
            make.centerX.equalToSuperview()
            make.width.equalTo(280 * (UIScreen.main.bounds.size.width / 375))
            make.height.equalTo(height == 1 ? 415 : (415 * height) * 0.85)
        }
    }
}
