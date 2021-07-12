//
//  EditCatchuVC.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/13.
//

import UIKit

import SnapKit

class EditCatchuVC: UIViewController {
    // MARK: - Lazy Properties
    lazy var navigationBar = CustomNavigationBar(self, title: "캐츄 수정")
    
    // MARK: - Properties
    let backgroundImageView = UIImageView()
    let height = UIApplication.statusBarHeight

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configUI()
    }
    
    // MARK: - Custom Method
    private func setupLayout() {
        view.addSubviews([navigationBar])
        
        navigationBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(59 + height)
        }
    }
    
    private func configUI() {
        view.backgroundColor = .black100
    }
}
