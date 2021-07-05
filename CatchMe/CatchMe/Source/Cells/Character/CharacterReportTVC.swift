//
//  CharacterReportTVC.swift
//  CatchMe
//
//  Created by Thisisme Hi on 2021/07/04.
//

import UIKit

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
    
    let catchNumberLabel = UILabel().then {
        $0.text = "50%"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        
        let attributtedString = NSMutableAttributedString(string: $0.text!)
        attributtedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 15, weight: .bold), range: ($0.text! as NSString).range(of:"%"))
                
        $0.attributedText = attributtedString
    }
    
    let catchLabel = UILabel().then {
        $0.text = "캐치지수"
        $0.textColor = .gray
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    let catchGuideButton = UIButton().then {
//        $0.setImage(UIImage(named: ""), for: .normal)
//        $0.addTarget(self, action: #selector(pressCatchGuidebutton), for: .touchDown)
        $0.backgroundColor = .orange
    }
    
    let separateLineRightView = UIView().then {
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
        $0.text = "활동수"
        $0.textColor = .gray
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    let lineBottomView = UIView().then {
        $0.backgroundColor = .gray
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Custom Method
    func setupAutoLayout() {
        backgroundColor = .black
        
        addSubviews([lineTopView, levelStackView, separateLineLeftView,
                     catchNumberLabel, catchLabel, catchGuideButton,
                     separateLineRightView, activityStackView, lineBottomView])
        
        levelStackView.addArrangedSubview(levelNumberLabel)
        levelStackView.addArrangedSubview(levelLabel)
        
        activityStackView.addArrangedSubview(activityNumberLabel)
        activityStackView.addArrangedSubview(activityLabel)
        
        lineTopView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(4)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        levelStackView.snp.makeConstraints { make in
            make.top.equalTo(lineTopView.snp.bottom).offset(12)
            make.leading.equalTo(self.snp.leading).inset(57)
        }
        
        separateLineLeftView.snp.makeConstraints { make in
            make.top.equalTo(lineTopView.snp.bottom).offset(12)
            make.bottom.equalTo(lineBottomView.snp.top).offset(-11)
            make.leading.equalTo(levelStackView.snp.trailing).offset(42)
            make.width.equalTo(1)
            make.height.equalTo(42)
        }
        
        catchNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(lineTopView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
        
        catchLabel.snp.makeConstraints { make in
            make.top.equalTo(catchNumberLabel.snp.bottom).offset(3)
            make.leading.equalTo(separateLineLeftView.snp.trailing).offset(26)
        }
        
        catchGuideButton.snp.makeConstraints { make in
            make.top.equalTo(lineTopView.snp.bottom).offset(31)
            make.leading.equalTo(catchLabel.snp.trailing).offset(-5)
            make.width.height.equalTo(30)
        }
        
        separateLineRightView.snp.makeConstraints { make in
            make.top.equalTo(lineTopView.snp.bottom).offset(12)
            make.bottom.equalTo(lineBottomView.snp.top).offset(-11)
            make.leading.equalTo(catchGuideButton.snp.trailing).offset(22)
            make.width.equalTo(1)
            make.height.equalTo(42)
        }
        
        activityStackView.snp.makeConstraints { make in
            make.top.equalTo(lineTopView.snp.bottom).offset(12)
            make.trailing.equalTo(self.snp.trailing).inset(50)
        }
        
        lineBottomView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(70)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.snp.bottom).offset(0)
            make.height.equalTo(1)
        }
    }
    
    @objc func pressCatchGuidebutton() {
        
    }
    
    func setData(level: String, percent: String, activity: String) {
        levelLabel.text = level
        catchLabel.text = percent
        activityLabel.text = activity
    }
}
