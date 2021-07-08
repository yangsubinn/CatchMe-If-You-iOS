//
//  SettingTVC.swift
//  CatchMe
//
//  Created by 양수빈 on 2021/07/07.
//

import UIKit

import SnapKit

class SettingTVC: UITableViewCell {
    static let identifier = "SettingTVC"
    
    // MARK: - Properties
    let titleLabel = UILabel()
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Custom Method
    func setupLayout() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(22)
        }
    }
}
