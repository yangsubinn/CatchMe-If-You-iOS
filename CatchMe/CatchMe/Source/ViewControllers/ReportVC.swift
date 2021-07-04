//
//  ReportVC.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/02.
//

import UIKit
import SnapKit

class ReportVC: UIViewController {
    // MARK: - lazy Properties
    lazy var backButton = BackButton(self)
    
    // MARK: - Properties
    let reportView = ReportView()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
    }
    
    // MARK: - Custom Methods
    fileprivate func configUI() {
        /// 색상 들어오면 변경할 것
        view.backgroundColor = .black
        setupStatusBar(.systemPink)
    }
    
    private func setupLayout() {
        view.addSubviews([reportView, backButton])
        
        reportView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.size.height * 0.41)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(55)
            make.leading.equalToSuperview().inset(14)
        }
    }
}
