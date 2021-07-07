//
//  FirstFlowView.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/07.
//

import UIKit

import SnapKit

class FirstFlowView: UIView {
    let titleView = CatchuTitleView(title: "새로운 캐츄를 잡아볼까요?", subTitle: "내 모습을 가장 잘 보여주는 캐츄를 골라주세요")

    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        titleView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(28)
        }
    }
    
    // MARK: - Custom Methods
    private func configUI() {
        addSubviews([titleView])
    }
}
