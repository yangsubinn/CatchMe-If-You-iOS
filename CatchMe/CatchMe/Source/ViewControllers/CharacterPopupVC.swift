//
//  CharacterPopupVC.swift
//  CatchMe
//
//  Created by Thisisme Hi on 2021/07/07.
//

import UIKit

import SnapKit

class CharacterPopupVC: UIViewController {
    // MARK: - lazy Properties
    lazy var popupView = CharacterPopupView(vc: self)

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
    }
    
    // MARK: - Custom Method
    private func configUI() {
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)
        popupView.deleteButton.addTarget(self, action: #selector(touchupDeleteButton(_:)), for: .touchUpInside)
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
    
    @objc func touchupDeleteButton(_ sender: UIButton) {
        AddActionDeleteService.shared.deleteActivity(index: 1, activityIndex: 2) { result in
            switch result {
            case .success(let msg):
                if let msg = msg as? String {
                    print("success", msg)
                }
                self.dismiss(animated: true, completion: nil)
            case .requestErr(let msg):
                print("requestERR", msg)
            case .pathErr:
                print("pathERR")
            case .serverErr:
                print("serverERR")
            case .networkFail:
                print("networkFail")
            }
        }
    }
}
