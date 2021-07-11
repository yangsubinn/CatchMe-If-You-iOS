//
//  LookVC.swift
//  CatchMe
//
//  Created by 양수빈 on 2021/07/12.
//

import UIKit

import SnapKit

class LookVC: UIViewController {
    //MARK: - Properties
    lazy var backButton = BackButton(self)
    let titleLabel = UILabel()
    let subLabel = UILabel()
    let topImageView = UIImageView()
    let topBackView  = UIView()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - Custom Method
    func setupLayout() {
        view.addSubviews([topBackView, backButton, titleLabel, subLabel, topImageView])
        
        topBackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(subLabel.snp.bottom).offset(47)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(55)
            make.leading.equalToSuperview().offset(14)
        }
    }
    
    func configUI() {
        
    }
}
