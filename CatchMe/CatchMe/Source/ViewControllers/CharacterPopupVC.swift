//
//  CharacterPopupVC.swift
//  CatchMe
//
//  Created by Thisisme Hi on 2021/07/07.
//

import UIKit

class CharacterPopupVC: UIViewController {
    // MARK: - lazy Properties
    lazy var popupView = CharacterPopupView(vc: self)

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        popupView.cancelButton.addTarget(self, action: #selector(touchupCancelButton(_:)), for: .touchUpInside)
        popupView.deleteButton.addTarget(self, action: #selector(touchupDeleteButton(_:)), for: .touchUpInside)
        
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)
    }
    
    // MARK: - Custom Method
    private func setupLayout() {
        view.addSubview(popupView)
        
        let height = UIScreen.main.bounds.size.height / 667
        
        popupView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).inset(UIScreen.main.bounds.size.height * 0.4)
            make.centerX.equalToSuperview()
            make.width.equalTo(301 * (UIScreen.main.bounds.size.width / 375))
            make.height.equalTo(height == 1 ? 152 : (152 * height) * 0.85)
        }
    }

    @objc func touchupCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func touchupDeleteButton(_ sender: UIButton) {
    // 삭제를 시키는 코드를 작성해야 합니다.
    }
}
