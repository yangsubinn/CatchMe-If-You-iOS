//
//  ReportPopupVC.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/06.
//

import UIKit

class ReportPopupVC: UIViewController {
    // MARK: - lazy Properties
    lazy var popupView = PopupView(date: date ?? "", vc: self)
    
    // MARK: - Properties
    var date: String?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    // MARK: - Custom Method
    private func setupLayout() {
        view.addSubview(popupView)
        
        popupView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(UIScreen.main.bounds.size.height * 0.2)
            make.centerX.equalToSuperview()
            make.width.equalTo(280)
            make.height.equalTo(415)
        }
    }
}
