//
//  CatchuTitleView.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/07.
//

import UIKit

import Then
import SnapKit

class CatchuTitleView: UIView {
    // MARK: - Properties
    let titleLabel = UILabel().then {
        $0.font = .stringMediumSystemFont(ofSize: 22)
        $0.textColor = .white
    }
    
    let subTitleLabel = UILabel().then {
        $0.font = .stringMediumSystemFont(ofSize: 14)
        $0.textColor = .white
    }
    
    // MARK: - Life Cycle
    init(title: String, subTitle: String) {
        super.init(frame: .zero)
        configUI(title: title, subTitle: subTitle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(titleLabel.snp.leading)
        }
    }
    
    // MARK: - Custom Method
    private func configUI(title: String, subTitle: String) {
        addSubviews([titleLabel, subTitleLabel])
        
        titleLabel.text = "새로운 캐츄를 잡아볼까요?"
        titleLabel.addAddCatchuCharacterSpacing()
        
        subTitleLabel.text = subTitle
        subTitleLabel.addCharacterSpacing()
    }
}
