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
            make.top.equalTo(view.safeAreaLayoutGuide).inset(145)
            make.leading.equalToSuperview().inset(47)
            make.trailing.equalToSuperview().inset(48)
            make.bottom.equalToSuperview().inset(208)
        }
    }
}
