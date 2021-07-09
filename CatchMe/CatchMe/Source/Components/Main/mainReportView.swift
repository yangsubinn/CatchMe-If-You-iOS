//
//  mainReportView.swift
//  CatchMe
//
//  Created by 양수빈 on 2021/07/04.
//

import UIKit

import SnapKit

class mainReportView: UIView {
    //MARK: - Properties
    let topLineView = UIView()
    let titleLabel = UILabel()
    let levelCountLabel = UILabel()
    let activeCountLabel = UILabel()
    let percentCountLabel = UILabel()
    let levelUnitLabel = UILabel()
    let activeUnitLabel = UILabel()
    let percentUnitLabel = UILabel()
    let levelLabel = UILabel()
    let activeLabel = UILabel()
    let percentLabel = UILabel()
    let lineLeftView = UIView()
    let lineRightView = UIView()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    private func setupLayout() {
        addSubviews([topLineView, titleLabel, levelCountLabel,
                     activeCountLabel, percentCountLabel, levelUnitLabel,
                     activeUnitLabel, percentUnitLabel, levelLabel,
                     activeLabel, percentLabel, lineLeftView, lineRightView])
        
        topLineView.snp.makeConstraints { make in
            make.height.equalTo(3)
            make.width.equalTo(36)
            make.leading.equalToSuperview().offset(24)
            make.top.equalToSuperview().offset(18)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(22)
            make.top.equalTo(topLineView.snp.bottom).offset(10)
        }
        
        activeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-27)
        }
        
        percentLabel.snp.makeConstraints { make in
            make.leading.equalTo(activeLabel.snp.trailing).offset(62)
            make.bottom.equalToSuperview().offset(-27)
        }
        
        lineLeftView.snp.makeConstraints { make in
            make.height.equalTo(23)
            make.width.equalTo(2)
            make.trailing.equalTo(activeLabel.snp.leading).offset(-29.5)
            make.bottom.equalToSuperview().offset(-45)
        }
        
        lineRightView.snp.makeConstraints { make in
            make.height.equalTo(23)
            make.width.equalTo(2)
            make.leading.equalTo(activeLabel.snp.trailing).offset(29.5)
            make.bottom.equalToSuperview().offset(-45)
        }
        
        activeUnitLabel.snp.makeConstraints { make in
            make.bottom.equalTo(activeLabel.snp.top).offset(-10)
            make.trailing.equalTo(lineRightView.snp.leading).offset(-22)
        }
        
        activeCountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(activeLabel.snp.top).offset(-6)
            make.trailing.equalTo(activeUnitLabel.snp.leading).offset(-4)
        }
        
        levelLabel.snp.makeConstraints { make in
            make.trailing.equalTo(activeLabel.snp.leading).offset(-67.5)
            make.bottom.equalToSuperview().offset(-27)
        }
        
        levelUnitLabel.snp.makeConstraints { make in
            make.bottom.equalTo(activeLabel.snp.top).offset(-10)
            make.trailing.equalTo(lineLeftView.snp.leading).offset(-22)
        }
        
        levelCountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(activeLabel.snp.top).offset(-6)
            make.trailing.equalTo(levelUnitLabel.snp.leading).offset(-4)
        }
        
        percentUnitLabel.snp.makeConstraints { make in
            make.bottom.equalTo(activeLabel.snp.top).offset(-10)
            make.leading.equalTo(lineRightView.snp.trailing).offset(60)
        }
        
        percentCountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(activeLabel.snp.top).offset(-6)
            make.trailing.equalTo(percentUnitLabel.snp.leading).offset(-4)
        }
    }
    
    private func configUI() {
        topLineView.backgroundColor = .systemPink
        topLineView.layer.cornerRadius = 2
        
        titleLabel.text = "활동 리포트"
        titleLabel.textColor = .white
        titleLabel.font = .stringMediumSystemFont(ofSize: 13)
        
        activeLabel.text = "총 활동"
        activeLabel.textColor = .white
        activeLabel.font = .stringMediumSystemFont(ofSize: 13)
        
        levelLabel.text = "레벨"
        levelLabel.textColor = .white
        levelLabel.font = .stringMediumSystemFont(ofSize: 13)
        
        percentLabel.text = "전체중"
        percentLabel.textColor = .white
        percentLabel.font = .stringMediumSystemFont(ofSize: 13)
        
        lineLeftView.backgroundColor = .white
        lineLeftView.layer.cornerRadius = 2
        
        lineRightView.backgroundColor = .white
        lineRightView.layer.cornerRadius = 2
        
        activeUnitLabel.text = "번"
        activeUnitLabel.textColor = .white
        activeUnitLabel.font = .stringMediumSystemFont(ofSize: 13)
        
        activeCountLabel.text = "10"
        activeCountLabel.textColor = .white
        activeCountLabel.font = .numberMediumSystemFont(ofSize: 32)
        
        levelUnitLabel.text = "Lv"
        levelUnitLabel.textColor = .white
        levelUnitLabel.font = .numberMediumSystemFont(ofSize: 13)
        
        levelCountLabel.text = "18"
        levelCountLabel.textColor = .white
        levelCountLabel.font = .numberMediumSystemFont(ofSize: 32)
        
        percentUnitLabel.text = "%"
        percentUnitLabel.textColor = .white
        percentUnitLabel.font = .numberMediumSystemFont(ofSize: 13)
        
        percentCountLabel.text = "24"
        percentCountLabel.textColor = .white
        percentCountLabel.font = .numberMediumSystemFont(ofSize: 32)
    }
}
