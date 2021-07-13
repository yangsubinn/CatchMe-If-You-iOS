//
//  CharacterReportTVC.swift
//  CatchMe
//
//  Created by Thisisme Hi on 2021/07/04.
//

import UIKit

import Then
import SnapKit

class CharacterReportTVC: UITableViewCell {
    static let idenfitifer = "CharacterReportTVC"
    
    // MARK: - Properties
    let lineTopView = UIView().then {
        $0.backgroundColor = .black300
    }
    
    let levelStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 3
        $0.alignment = .center
    }
    
    let levelNumberLabel = UILabel().then {
        $0.text = "1"
        $0.textColor = .white
        $0.font = .numberBoldSystemFont(ofSize: 20)
    }
    
    let levelLabel = UILabel().then {
        $0.text = "레벨"
        $0.textColor = .gray300
        $0.font = .stringRegularSystemFont(ofSize: 14)
    }
    
    let separateLineLeftView = UIView().then {
        $0.backgroundColor = .black300
    }
    
    let activityStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 3
        $0.alignment = .center
    }
    
    let activityNumberLabel = UILabel().then {
        $0.text = "23"
        $0.textColor = .white
        $0.font = .numberBoldSystemFont(ofSize: 20)
    }
    
    let activityLabel = UILabel().then {
        $0.text = "활동 수"
        $0.textColor = .gray300
        $0.font = .stringRegularSystemFont(ofSize: 14)
    }
    
    let separateLineRightView = UIView().then {
        $0.backgroundColor = .black300
    }
    
    let catchNumberLabel = UILabel().then {
        $0.text = "50%"
        $0.textColor = .white
        $0.font = .numberBoldSystemFont(ofSize: 20)
        
        let attributtedString = NSMutableAttributedString(string: $0.text!)
        attributtedString.addAttribute(.font, value: UIFont.numberBoldSystemFont(ofSize: 15), range: ($0.text! as NSString).range(of:"%"))
        $0.attributedText = attributtedString
    }

    let catchLabel = UILabel().then {
        $0.text = "캐치지수"
        $0.textColor = .gray300
        $0.font = .stringRegularSystemFont(ofSize: 14)
    }
    
    let exclamationMarkImageView = UIImageView().then {
        $0.image = UIImage(named: "btnGuide")
    }
    
    let catchGuideButton = UIButton().then {
        $0.backgroundColor = .clear
    }
    
    let lineBottomView = UIView().then {
        $0.backgroundColor = .black300
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Custom Method
    func setupAutoLayout() {
        self.sendSubviewToBack(contentView)
        backgroundColor = .black100
        
        addSubviews([lineTopView, levelStackView, separateLineLeftView,
                     activityStackView, separateLineRightView,
                     catchNumberLabel, exclamationMarkImageView, catchLabel,
                     catchGuideButton, lineBottomView])
        levelStackView.addArrangedSubview(levelNumberLabel)
        levelStackView.addArrangedSubview(levelLabel)
        activityStackView.addArrangedSubview(activityNumberLabel)
        activityStackView.addArrangedSubview(activityLabel)
        
        lineTopView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(5)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        levelStackView.snp.makeConstraints { make in
            make.top.equalTo(lineTopView.snp.bottom).offset(10)
            make.leading.equalTo(self.snp.leading).inset(57)
        }
        
        separateLineLeftView.snp.makeConstraints { make in
            make.top.equalTo(lineTopView.snp.bottom).offset(12)
            make.bottom.equalTo(lineBottomView.snp.top).offset(-11)
            make.leading.equalTo(levelStackView.snp.trailing).offset(42)
            make.width.equalTo(1)
            make.height.equalTo(42)
        }
        
        activityStackView.snp.makeConstraints { make in
            make.top.equalTo(lineTopView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        separateLineRightView.snp.makeConstraints { make in
            make.top.equalTo(lineTopView.snp.bottom).offset(12)
            make.bottom.equalTo(lineBottomView.snp.top).offset(-11)
            make.leading.equalTo(activityStackView.snp.trailing).offset(42)
            make.width.equalTo(1)
            make.height.equalTo(42)
        }
        
        catchNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(lineTopView.snp.bottom).offset(10)
            make.trailing.equalTo(self.snp.trailing).inset(43)
        }
        
        catchLabel.snp.makeConstraints { make in
            make.top.equalTo(catchNumberLabel.snp.bottom).offset(3)
            make.leading.equalTo(separateLineRightView.snp.trailing).offset(25)
        }
        
        exclamationMarkImageView.snp.makeConstraints { make in
            make.top.equalTo(lineTopView.snp.bottom).offset(33)
            make.leading.equalTo(catchLabel.snp.trailing).offset(-5)
            make.trailing.equalTo(self.snp.trailing).inset(20)
            make.width.height.equalTo(30)
        }
        
        catchGuideButton.snp.makeConstraints { make in
            make.top.equalTo(lineTopView.snp.bottom).offset(31)
            make.leading.equalTo(separateLineRightView.snp.trailing).offset(16)
            make.width.equalTo(79)
            make.height.equalTo(30)
        }
        
        lineBottomView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(70)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.snp.bottom).offset(0)
            make.height.equalTo(1)
        }
    }
    
    func setData(level: String, percent: String, activity: String) {
        levelLabel.text = level
        catchLabel.text = percent
        activityLabel.text = activity
    }
}
