//
//  AddCatchuVC.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/07.
//

import UIKit

import SnapKit

class AddCatchuVC: UIViewController {
    // MARK: - lazy Properties
    lazy var xmarkButton = XmarkButton(self)
    
    // MARK: - Properties
    let backButton = BackButton()
    let pageControl = AddCatchuPageControl()
    let firstFlowView = FirstFlowView()
    let bottomButton = BottomButton(title: "잡았다!")
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configUI()
        setupButtonAction()
    }
    
    // MARK: - Custom Methods
    private func setupLayout() {
        view.addSubviews([xmarkButton, backButton, pageControl,
                          firstFlowView, bottomButton])
        
        xmarkButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(11)
            make.trailing.equalToSuperview().inset(12)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(xmarkButton.snp.top)
            make.leading.equalToSuperview().inset(11)
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(75)
            make.leading.equalToSuperview().inset(28)
            make.width.equalTo(40)
            make.height.equalTo(12)
        }
        
        bottomButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(50)
            make.leading.trailing.equalToSuperview().inset(28)
        }
        
        firstFlowView.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(bottomButton.snp.top)
        }
    }
    
    private func configUI() {
        view.backgroundColor = .black
        
        pageControl.pages = 3
    }
    
    private func setupButtonAction() {
        let previousAction = UIAction { _ in
            
        }
        backButton.addAction(previousAction, for: .touchUpInside)
    }
}
