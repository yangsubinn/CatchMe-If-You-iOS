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
    lazy var navigationBar = CustomNavigationBar(self, title: "회원가입")
    
    // MARK: - Properties

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    // MARK: - Custom Method
    private func configUI() {
        view.backgroundColor = .black100
    }
}
