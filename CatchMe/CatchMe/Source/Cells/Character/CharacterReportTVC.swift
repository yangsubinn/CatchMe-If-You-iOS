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
        $0.backgroundColor = .gray
    }
    
    let levelStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 3
        $0.alignment = .center
    }
    
    let levelNumberLabel = UILabel().then {
        $0.text = "1"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    let levelLabel = UILabel().then {
        $0.text = "레벨"
        $0.textColor = .gray
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    let separateLineLeftView = UIView().then {
        $0.backgroundColor = .gray
    }
    
    let activityStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 3
        $0.alignment = .center
    }
    
    let activityNumberLabel = UILabel().then {
        $0.text = "23"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    let activityLabel = UILabel().then {
        $0.text = "활동 수"
        $0.textColor = .gray
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    let separateLineRightView = UIView().then {
        $0.backgroundColor = .gray
    }
    
    let catchNumberLabel = UILabel().then {
        $0.text = "50%"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        
        let attributtedString = NSMutableAttributedString(string: $0.text!)
        attributtedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 15, weight: .bold), range: ($0.text! as NSString).range(of:"%"))
        
        $0.attributedText = attributtedString
    }
    
    let catchGuideImageView = UIImageView().then {
        //        $0.setImage(UIImage(named: ""), for: .normal)
        $0.backgroundColor = .purple
    }
    
    let catchLabel = UILabel().then {
        $0.text = "캐치지수"
        $0.textColor = .gray
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    let exclamationMarkImageView = UIImageView().then {
        //        $0.setImage(UIImage(named: ""), for: .normal)
        $0.backgroundColor = .orange
    }
    
    let catchGuideButton = UIButton().then {
        $0.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
    }
    
    let lineBottomView = UIView().then {
        $0.backgroundColor = .gray
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
        backgroundColor = .black
        
        addSubviews([lineTopView, levelStackView, separateLineLeftView,
                     activityStackView, separateLineRightView,
                     catchNumberLabel, catchLabel, exclamationMarkImageView,
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
            make.leading.equalTo(separateLineRightView.snp.trailing).offset(27)
        }
        
        exclamationMarkImageView.snp.makeConstraints { make in
            make.top.equalTo(lineTopView.snp.bottom).offset(31)
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
