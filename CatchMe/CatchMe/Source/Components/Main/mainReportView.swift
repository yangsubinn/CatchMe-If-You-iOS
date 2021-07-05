//
//  mainReportView.swift
//  CatchMe
//
//  Created by 양수빈 on 2021/07/04.
//

import UIKit

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
    let lineViewLeft = UIView()
    let lineViewRight = UIView()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configViewStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    private func configViewStyle() {
        addSubviews([topLineView, titleLabel, levelCountLabel, activeCountLabel, percentCountLabel, levelUnitLabel, activeUnitLabel, percentUnitLabel, levelLabel, activeLabel, percentLabel, lineViewLeft, lineViewRight])
        
        topLineView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        topLineView.snp.makeConstraints { make in
            make.height.equalTo(3)
            make.width.equalTo(36)
            make.leading.equalToSuperview().offset(24)
            make.top.equalToSuperview().offset(18)
        }
        topLineView.backgroundColor = .systemPink
        topLineView.layer.cornerRadius = 2
        
        titleLabel.text = "활동 리포트"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(22)
            make.top.equalTo(topLineView.snp.bottom).offset(10)
        }
        
        activeLabel.text = "총 활동"
        activeLabel.textColor = .white
        activeLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        activeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-27)
        }
        
        levelLabel.text = "레벨"
        levelLabel.textColor = .white
        levelLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        levelLabel.snp.makeConstraints { make in
            make.trailing.equalTo(activeLabel.snp.leading).offset(-67.5)
            make.bottom.equalToSuperview().offset(-27)
        }
        
        percentLabel.text = "전체중"
        percentLabel.textColor = .white
        percentLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        percentLabel.snp.makeConstraints { make in
            make.leading.equalTo(activeLabel.snp.trailing).offset(62)
            make.bottom.equalToSuperview().offset(-27)
        }
        
        lineViewLeft.backgroundColor = .white
        lineViewLeft.layer.cornerRadius = 2
        lineViewLeft.snp.makeConstraints { make in
            make.height.equalTo(23)
            make.width.equalTo(2)
            make.trailing.equalTo(activeLabel.snp.leading).offset(-29.5)
            make.bottom.equalToSuperview().offset(-45)
        }
        
        lineViewRight.backgroundColor = .white
        lineViewRight.layer.cornerRadius = 2
        lineViewRight.snp.makeConstraints { make in
            make.height.equalTo(23)
            make.width.equalTo(2)
            make.leading.equalTo(activeLabel.snp.trailing).offset(29.5)
            make.bottom.equalToSuperview().offset(-45)
        }
        
        activeUnitLabel.text = "번"
        activeUnitLabel.textColor = .white
        activeUnitLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        activeUnitLabel.snp.makeConstraints { make in
            make.bottom.equalTo(activeLabel.snp.top).offset(-10)
            make.trailing.equalTo(lineViewRight.snp.leading).offset(-22)
        }
        
        activeCountLabel.text = "10"
        activeCountLabel.textColor = .white
        activeCountLabel.font = UIFont.systemFont(ofSize: 32, weight: .medium)
        activeCountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(activeLabel.snp.top).offset(-6)
            make.trailing.equalTo(activeUnitLabel.snp.leading).offset(-4)
        }
        
        levelUnitLabel.text = "Lv"
        levelUnitLabel.textColor = .white
        levelUnitLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        levelUnitLabel.snp.makeConstraints { make in
            make.bottom.equalTo(activeLabel.snp.top).offset(-10)
            make.trailing.equalTo(lineViewLeft.snp.leading).offset(-22)
        }
        
        levelCountLabel.text = "18"
        levelCountLabel.textColor = .white
        levelCountLabel.font = UIFont.systemFont(ofSize: 32, weight: .medium)
        levelCountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(activeLabel.snp.top).offset(-6)
            make.trailing.equalTo(levelUnitLabel.snp.leading).offset(-4)
        }
        
        percentUnitLabel.text = "%"
        percentUnitLabel.textColor = .white
        percentUnitLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        percentUnitLabel.snp.makeConstraints { make in
            make.bottom.equalTo(activeLabel.snp.top).offset(-10)
            make.leading.equalTo(lineViewRight.snp.trailing).offset(60)
        }
        
        percentCountLabel.text = "24"
        percentCountLabel.textColor = .white
        percentCountLabel.font = UIFont.systemFont(ofSize: 32, weight: .medium)
        percentCountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(activeLabel.snp.top).offset(-6)
            make.trailing.equalTo(percentUnitLabel.snp.leading).offset(-4)
        }
    }
}
