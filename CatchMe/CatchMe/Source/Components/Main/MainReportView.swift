//
//  MainReportView.swift
//  CatchMe
//
//  Created by 양수빈 on 2021/07/04.
//

import UIKit

import SnapKit

class MainReportView: UIView {
    //MARK: - Properties
    let topLineView = UIView()
    let titleLabel = UILabel()
    let levelCountLabel = UILabel()
    let activeCountLabel = UILabel()
    let percentCountLabel = UILabel()
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
                     activeCountLabel, percentCountLabel, levelLabel,
                     activeLabel, percentLabel, lineLeftView, lineRightView])

        topLineView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.equalToSuperview().offset(24)
            make.width.equalTo(36)
            make.height.equalTo(3)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(topLineView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(22)
        }
        
        lineLeftView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(45)
            make.trailing.equalTo(activeLabel.snp.leading).offset(-35)
            make.width.equalTo(2)
            make.height.equalTo(23)
        }
         
        lineRightView.snp.makeConstraints { make in
            make.leading.equalTo(activeLabel.snp.trailing).offset(35)
            make.bottom.equalToSuperview().inset(45)
            make.width.equalTo(2)
            make.height.equalTo(23)
        }
        
        activeLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(27)
            make.centerX.equalToSuperview()
        }
        
        percentLabel.snp.makeConstraints { make in
            make.leading.equalTo(lineRightView.snp.trailing).offset(25)
            make.bottom.equalToSuperview().inset(27)
        }
        
        levelLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(27)
            make.trailing.equalTo(lineLeftView.snp.leading).offset(-38) //-33.5
        }
        
        activeCountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(activeLabel.snp.top).offset(-6)
            make.centerX.equalToSuperview()
        }
        
        levelCountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(activeLabel.snp.top).offset(-6)
            make.centerX.equalTo(levelLabel.snp.centerX)
        }
        
        percentCountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(activeLabel.snp.top).offset(-6)
            make.centerX.equalTo(percentLabel.snp.centerX)
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
        
        activeLabel.text = "캐칭"
        activeLabel.textColor = .white
        activeLabel.font = .stringMediumSystemFont(ofSize: 13)
        
        levelLabel.text = "레벨"
        levelLabel.textColor = .white
        levelLabel.font = .stringMediumSystemFont(ofSize: 13)
        
        percentLabel.text = "캐치지수"
        percentLabel.textColor = .white
        percentLabel.font = .stringMediumSystemFont(ofSize: 13)
        
        activeCountLabel.text = "10"
        activeCountLabel.textColor = .white
        activeCountLabel.font = .numberMediumSystemFont(ofSize: 32)
        
        levelCountLabel.text = "1"
        levelCountLabel.textColor = .white
        levelCountLabel.font = .numberMediumSystemFont(ofSize: 32)
        
        percentCountLabel.text = "100"
        percentCountLabel.textColor = .white
        percentCountLabel.font = .numberMediumSystemFont(ofSize: 32)
        
        emptyTitleLabel.text = "아직 캐츄의 활동이 없어요"
        emptyTitleLabel.textColor = .white
        emptyTitleLabel.font = .stringMediumSystemFont(ofSize: 20)
        
        emptySubLabel.text = "캐칭을 기록하고 리포트로 확인해볼까요?"
        emptySubLabel.textColor = .white
        emptySubLabel.font = .stringRegularSystemFont(ofSize: 14)
    }
}
