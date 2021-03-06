//
//  MainReportView.swift
//  CatchMe
//
//  Created by μμλΉ on 2021/07/04.
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
        setupEmptyLayout()
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
    
    func setupEmptyLayout() {
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
    
    func emptyUI() {
        topLineView.isHidden = true
        titleLabel.isHidden = true
        levelCountLabel.isHidden = true
        activeCountLabel.isHidden = true
        percentCountLabel.isHidden = true
        levelLabel.isHidden = true
        activeLabel.isHidden = true
        percentLabel.isHidden = true
        lineLeftView.isHidden = true
        lineRightView.isHidden = true
        
        emptyTitleLabel.isHidden = false
        emptySubLabel.isHidden = false
    }
    
    func dataUI() {
        topLineView.isHidden = false
        titleLabel.isHidden = false
        levelCountLabel.isHidden = false
        activeCountLabel.isHidden = false
        percentCountLabel.isHidden = false
        levelLabel.isHidden = false
        activeLabel.isHidden = false
        percentLabel.isHidden = false
        lineLeftView.isHidden = false
        lineRightView.isHidden = false
        
        emptyTitleLabel.isHidden = true
        emptySubLabel.isHidden = true
    }
    
    private func configUI() {
        topLineView.backgroundColor = .pink100
        topLineView.layer.cornerRadius = 2

        lineLeftView.backgroundColor = .white
        lineLeftView.layer.cornerRadius = 2
        
        lineRightView.backgroundColor = .white
        lineRightView.layer.cornerRadius = 2
        
        titleLabel.text = "νλ λ¦¬ν¬νΈ"
        titleLabel.textColor = .white
        titleLabel.font = .stringMediumSystemFont(ofSize: 13)
        
        activeLabel.text = "μΊμΉ­"
        activeLabel.textColor = .white
        activeLabel.font = .stringMediumSystemFont(ofSize: 13)
        
        levelLabel.text = "λ λ²¨"
        levelLabel.textColor = .white
        levelLabel.font = .stringMediumSystemFont(ofSize: 13)
        
        percentLabel.text = "μΊμΉμ§μ"
        percentLabel.textColor = .white
        percentLabel.font = .stringMediumSystemFont(ofSize: 13)
        
        activeCountLabel.textColor = .white
        activeCountLabel.font = .numberMediumSystemFont(ofSize: 32)
        
        levelCountLabel.textColor = .white
        levelCountLabel.font = .numberMediumSystemFont(ofSize: 32)
        
        percentCountLabel.textColor = .white
        percentCountLabel.font = .numberMediumSystemFont(ofSize: 32)
        
        emptyTitleLabel.text = "μμ§ μΊμΈμ νλμ΄ μμ΄μ"
        emptyTitleLabel.textColor = .white
        emptyTitleLabel.font = .stringMediumSystemFont(ofSize: 20)
        emptyTitleLabel.addCharacterSpacing()
        
        emptySubLabel.text = "μΊμΉ­μ κΈ°λ‘νκ³  λ¦¬ν¬νΈλ‘ νμΈν΄λ³ΌκΉμ?"
        emptySubLabel.textColor = .white
        emptySubLabel.font = .stringRegularSystemFont(ofSize: 14)
        emptySubLabel.addCharacterSpacing()
        
        topLineView.isHidden = false
        titleLabel.isHidden = false
        levelCountLabel.isHidden = false
        activeCountLabel.isHidden = false
        percentCountLabel.isHidden = false
        levelLabel.isHidden = false
        activeLabel.isHidden = false
        percentLabel.isHidden = false
        lineLeftView.isHidden = false
        lineRightView.isHidden = false
        
        emptyTitleLabel.isHidden = true
        emptySubLabel.isHidden = true
    }
    
    func setLabel(level: Int, activity: Int, percent: Int) {
        levelCountLabel.text = "\(level)"
        activeCountLabel.text = "\(activity)"
        percentCountLabel.text = "\(percent)"
    }
}
