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
    
    let emptyTitleLabel = UILabel()
    let emptySubLabel = UILabel()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setupLayout()
//        setupEmptyLayout()
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
        
        lineLeftView.snp.makeConstraints { make in
            make.height.equalTo(23)
            make.width.equalTo(2)
            make.trailing.equalTo(activeLabel.snp.leading).offset(-29.5)
            make.bottom.equalToSuperview().inset(45)
        }
        
        lineRightView.snp.makeConstraints { make in
            make.height.equalTo(23)
            make.width.equalTo(2)
            make.leading.equalTo(activeLabel.snp.trailing).offset(29.5)
            make.bottom.equalToSuperview().inset(45)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(22)
            make.top.equalTo(topLineView.snp.bottom).offset(10)
        }
        
        activeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(27)
        }
        
        percentLabel.snp.makeConstraints { make in
            make.leading.equalTo(activeLabel.snp.trailing).offset(62)
            make.bottom.equalToSuperview().inset(27)
        }
        
        levelLabel.snp.makeConstraints { make in
            make.trailing.equalTo(activeLabel.snp.leading).offset(-67.5)
            make.bottom.equalToSuperview().inset(27)
        }
        
        /// unit
        activeUnitLabel.snp.makeConstraints { make in
            make.bottom.equalTo(activeLabel.snp.top).offset(-10)
            make.trailing.equalTo(lineRightView.snp.leading).offset(-28) //-28
        }
        
        levelUnitLabel.snp.makeConstraints { make in
            make.bottom.equalTo(activeLabel.snp.top).offset(-10)
            make.trailing.equalTo(lineLeftView.snp.leading).offset(-30) //-24
        }
        
        percentUnitLabel.snp.makeConstraints { make in
            make.bottom.equalTo(activeLabel.snp.top).offset(-10)
            make.leading.equalTo(lineRightView.snp.trailing).offset(60)
//            make.trailing.equalToSuperview().inset(36)
        }
        
        /// int
        activeCountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(activeLabel.snp.top).offset(-6)
            make.trailing.equalTo(activeUnitLabel.snp.leading).offset(-4)
        }
        
        levelCountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(activeLabel.snp.top).offset(-6)
            make.trailing.equalTo(levelUnitLabel.snp.leading).offset(-4)
        }
        
        // 분기처리해서 레이아웃 잡기
        percentCountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(activeLabel.snp.top).offset(-6)
//            make.centerX.equalTo(lineRightView.snp.trailing).offset(40)
            make.trailing.equalTo(percentUnitLabel.snp.leading).offset(-4)
        }
    }
    
    private func setupEmptyLayout() {
        addSubviews([emptyTitleLabel, emptySubLabel])
        
        emptyTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(51)
            make.centerX.equalToSuperview()
        }
        
        emptySubLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyTitleLabel.snp.bottom).offset(7)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configUI() {
        topLineView.backgroundColor = .pink100
        topLineView.layer.cornerRadius = 2

        lineLeftView.backgroundColor = .white
        lineLeftView.layer.cornerRadius = 2
        
        lineRightView.backgroundColor = .white
        lineRightView.layer.cornerRadius = 2
        
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
        
        activeUnitLabel.text = "번"
        activeUnitLabel.textColor = .white
        activeUnitLabel.font = .stringMediumSystemFont(ofSize: 13)
        
        activeCountLabel.text = "10"
        activeCountLabel.textColor = .white
        activeCountLabel.font = .numberMediumSystemFont(ofSize: 32)
        
        levelUnitLabel.text = "Lv"
        levelUnitLabel.textColor = .white
        levelUnitLabel.font = .numberMediumSystemFont(ofSize: 13)
        
        levelCountLabel.text = "3"
        levelCountLabel.textColor = .white
        levelCountLabel.font = .numberMediumSystemFont(ofSize: 32)
        
        percentUnitLabel.text = "%"
        percentUnitLabel.textColor = .white
        percentUnitLabel.font = .numberMediumSystemFont(ofSize: 13)
        
        percentCountLabel.text = "24"
        percentCountLabel.textColor = .white
        percentCountLabel.font = .numberMediumSystemFont(ofSize: 32)
        
        emptyTitleLabel.text = "아직 캐츄의 활동이 없어요"
        emptyTitleLabel.textColor = .white
        emptyTitleLabel.font = .stringMediumSystemFont(ofSize: 20)
        
        emptySubLabel.text = "캐칭을 기록하고 리포트로 확인해볼까요?"
        emptySubLabel.textColor = .white
        emptySubLabel.font = .stringRegularSystemFont(ofSize: 14)
    }
    
    // int값 계산해서 레이아웃 분기처리하는 함수
    func labelCount() {
        
    }
}
