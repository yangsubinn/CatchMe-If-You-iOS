//
//  AddCatchuVC.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/07.
//

import UIKit

import SnapKit

enum Flow: Int {
    case select = 1
    case naming = 2
    case complete = 3
}

class AddCatchuVC: UIViewController {
    // MARK: - lazy Properties
    lazy var xmarkButton = XmarkButton(self)
    
    // MARK: - Properties
    let backButton = BackButton()
    let pageControl = AddCatchuPageControl()
    let firstFlowView = FirstFlowView()
    let secondFlowView = SecondFlowView()
    let bottomButton = BottomButton(title: "잡았다!")
    
    var currentFlow = 1
    
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
                          firstFlowView, secondFlowView, bottomButton])
        
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
        
        secondFlowView.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(bottomButton.snp.top)
        }
    }
    
    private func configUI() {
        view.backgroundColor = .black100
        
        pageControl.pages = 3
        
        backButton.isHidden = true
        secondFlowView.isHidden = true
    }
    
    private func setupButtonAction() {
        let previousAction = UIAction { _ in
            self.currentFlow -= 1
            self.pageControl.selectedPage -= 1
            self.changeBackButtonState()
            self.changeFlowViewState()
        }
        backButton.addAction(previousAction, for: .touchUpInside)
        
        let nextAction = UIAction { _ in
            if self.currentFlow != Flow.complete.rawValue {
                self.currentFlow += 1
                self.pageControl.selectedPage += 1
                self.changeBackButtonState()
                self.changeFlowViewState()
            }
        }
        bottomButton.addAction(nextAction, for: .touchUpInside)
    }
    
    private func changeBackButtonState() {
        switch currentFlow {
        case Flow.select.rawValue:
            backButton.isHidden = true
        default:
            backButton.isHidden = false
        }
    }
    
    private func changeFlowViewState() {
        switch currentFlow {
        case Flow.select.rawValue:
            firstFlowView.isHidden = false
            secondFlowView.isHidden = true
            
            bottomButton.changeBottomButtonTitle(title: "잡았다!")
        case Flow.naming.rawValue:
            firstFlowView.isHidden = true
            secondFlowView.isHidden = false
            
            secondFlowView.setImageViewColor(selectedIndex: firstFlowView.previousIndex)
            bottomButton.changeBottomButtonTitle(title: "너로 정했다!")
            /// textField에 따라서 isEnable 변경
        case Flow.complete.rawValue:
            firstFlowView.isHidden = true
            secondFlowView.isHidden = true
            bottomButton.changeBottomButtonTitle(title: "탄생!")
        default: break
        }
    }
}
