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
    // MARK: - Properties
    let xmarkButton = XmarkButton()
    let backButton = BackButton()
    let pageControl = AddCatchuPageControl()
    let firstFlowView = FirstFlowView()
    let secondFlowView = SecondFlowView()
    let thirdFlowView = ThirdFlowView()
    let bottomButton = BottomButton(title: "잡았다!")
    
    var currentFlow = 1
    
    // MARK: - Connect Server
    let viewModel = MainCardViewModel.shared
    
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
                          firstFlowView, secondFlowView, thirdFlowView,
                          bottomButton])
        
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
            make.leading.trailing.equalToSuperview().inset(28)
            make.bottom.equalToSuperview().inset(50)
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
        
        thirdFlowView.snp.makeConstraints { make in
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
        thirdFlowView.isHidden = true
        
        hideKeyboardWhenTappedAround()
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
            } else if self.currentFlow == Flow.complete.rawValue {
                if let name = self.secondFlowView.textField.text {
                    self.viewModel.dispatchCreateCharacter(name: name, index: self.firstFlowView.previousIndex+1, privacy: self.thirdFlowView.isLock, vc: self)
                    self.dismiss(animated: true, completion: nil)
                }
                
            }
        }
        bottomButton.addAction(nextAction, for: .touchUpInside)
        
        let xmarkAction = UIAction { _ in
            guard let vc = self.storyboard?.instantiateViewController(identifier: "AddCatchuPopupVC") as? AddCatchuPopupVC else { return }
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
        }
        xmarkButton.addAction(xmarkAction, for: .touchUpInside)
    }
    
    // MARK: - @objc
    @objc
    override func dismissKeyboard() {
        view.endEditing(true)
        
        if currentFlow == Flow.naming.rawValue {
            UIView.animate(withDuration: 0.2, animations: {
                self.secondFlowView.characterImageView.transform = .identity
                self.secondFlowView.textField.transform = .identity
                self.secondFlowView.countLabel.transform = .identity
            })
            
            if secondFlowView.textField.hasText {
                bottomButton.isEnabled = true
                bottomButton.changeBottomButton(isEnable: true)
            } else {
                bottomButton.isEnabled = false
                bottomButton.changeBottomButton(isEnable: false)
            }
        }
    }
}

// MARK: - Helper
extension AddCatchuVC {
    private func changeBackButtonState() {
        switch currentFlow {
        case Flow.select.rawValue:
            backButton.isHidden = true
            
            secondFlowView.textField.text = ""
            secondFlowView.countLabel.text = "0/20"
        case Flow.naming.rawValue:
            backButton.isHidden = false
            
            thirdFlowView.isLock = false
            thirdFlowView.lockButton.setImage(UIImage(named: "checkboxActive"), for: .normal)
            thirdFlowView.lockLabel.textColor = .white
        default:
            backButton.isHidden = false
        }
    }
    
    private func changeFlowViewState() {
        switch currentFlow {
        case Flow.select.rawValue:
            /// FlowView hidden
            firstFlowView.isHidden = false
            secondFlowView.isHidden = true
            thirdFlowView.isHidden = true
            
            /// BottomButton Change
            bottomButton.isEnabled = true
            bottomButton.changeBottomButton(isEnable: true)
            bottomButton.changeBottomButtonTitle(title: "잡았다!")
        case Flow.naming.rawValue:
            /// FlowView hidden
            firstFlowView.isHidden = true
            secondFlowView.isHidden = false
            thirdFlowView.isHidden = true
            
            /// View Setting
            secondFlowView.setImageViewColor(selectedIndex: firstFlowView.previousIndex)
            
            /// BottomButton Change
            bottomButton.changeBottomButtonTitle(title: "너로 정했다!")
            if secondFlowView.textField.hasText {
                bottomButton.isEnabled = true
                bottomButton.changeBottomButton(isEnable: true)
            } else {
                bottomButton.isEnabled = false
                bottomButton.changeBottomButton(isEnable: false)
            }
        case Flow.complete.rawValue:
            /// FlowView hidden
            firstFlowView.isHidden = true
            secondFlowView.isHidden = true
            thirdFlowView.isHidden = false
            
            /// View Setting
            thirdFlowView.setImageViewColor(selectedIndex: firstFlowView.previousIndex)
            thirdFlowView.setCharacterName(name: secondFlowView.textField.text ?? "")
            
            /// BottomButton Change
            bottomButton.changeBottomButtonTitle(title: "탄생!")
        default:
            break
        }
    }
}
