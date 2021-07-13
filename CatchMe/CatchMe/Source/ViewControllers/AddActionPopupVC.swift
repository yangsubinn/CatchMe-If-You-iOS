//
//  AddActionPopupVC.swift
//  CatchMe
//
//  Created by Thisisme Hi on 2021/07/11.
//

import UIKit

import SnapKit

class AddActionPopupVC: UIViewController {
    // MARK: - lazy Properties
    lazy var popupView = AddActionPopupView(vc: self)

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
    }
    
    // MARK: - Custom Method
    private func configUI() {
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)
        
        popupView.closeButton.addTarget(self, action: #selector(touchupCloseButton(_:)), for: .touchUpInside)
    }
    
    private func setupLayout() {
        view.addSubview(popupView)
        
        let height = UIScreen.main.bounds.size.height / 667
        
        popupView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).inset(UIScreen.main.bounds.size.height * 0.4)
            make.centerX.equalToSuperview()
            make.width.equalTo(301 * (UIScreen.main.bounds.size.width / 375))
            make.height.equalTo(height == 1 ? 182 : (182 * height) * 0.85)
        }
    }
    
    @objc func touchupCloseButton(_ sender: UIButton) {
        guard let pvc = self.presentingViewController else { return }
        
        self.dismiss(animated: true) {
            pvc.dismiss(animated: true, completion: nil)
        }
    }
}
