//
//  CharacterReportTVC.swift
//  CatchMe
//
//  Created by Thisisme Hi on 2021/07/04.
//

import UIKit

class CharacterReportTVC: UITableViewCell {
    
    static let idenfitifer = "CharacterReportTVC"

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Property
    
    let lineView1 = UIView().then {
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
    
    let separateLineView1 = UIView().then {
        $0.backgroundColor = .gray
    }
    
    let catchNumberLabel = UILabel().then {
        $0.text = "50%"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 20, weight: .bold)
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
    
    let separateLineView2 = UIView().then {
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
    
    let lineView2 = UIView().then {
        $0.backgroundColor = .gray
    }
   
    
    // MARK: - configUI
    
    func configUI() {
        
        
    }
    
    // MARK: - setupAutoLayout
    
    func setupAutoLayout() {
        
        backgroundColor = .black
        
        addSubviews([lineView1, levelStackView, separateLineView1,
                     catchNumberLabel, catchLabel, catchGuideButton,
                     separateLineView2, activityStackView, lineView2])
        
        levelStackView.addArrangedSubview(levelNumberLabel)
        levelStackView.addArrangedSubview(levelLabel)
        
        activityStackView.addArrangedSubview(activityNumberLabel)
        activityStackView.addArrangedSubview(activityLabel)
        
        lineView1.snp.makeConstraints { (make) in
            make.top.equalTo(4)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        levelStackView.snp.makeConstraints { (make) in
            make.top.equalTo(lineView1.snp.bottom).offset(12)
            make.leading.equalTo(57)
        }
        
        separateLineView1.snp.makeConstraints { (make) in
            make.top.equalTo(lineView1.snp.bottom).offset(12)
            make.bottom.equalTo(lineView2.snp.top).offset(-11)
            make.leading.equalTo(levelStackView.snp.trailing).offset(42)
            make.width.equalTo(1)
        }
        
        catchNumberLabel.snp.makeConstraints { (make) in
            make.top.equalTo(lineView1.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
        
        catchLabel.snp.makeConstraints { (make) in
            make.top.equalTo(catchNumberLabel.snp.bottom).offset(3)
            make.leading.equalTo(separateLineView1.snp.trailing).offset(26)
        }
        
        catchGuideButton.snp.makeConstraints { (make) in
            make.top.equalTo(lineView1.snp.bottom).offset(31)
            make.leading.equalTo(catchLabel.snp.trailing).offset(-5)
//            make.bottom.equalTo(lineView2.snp.top).offset(-5)
            make.width.height.equalTo(30)
        }
        
        separateLineView2.snp.makeConstraints { (make) in
            make.top.equalTo(lineView1.snp.bottom).offset(12)
            make.bottom.equalTo(lineView2.snp.top).offset(-11)
            make.leading.equalTo(catchGuideButton.snp.trailing).offset(22)
            make.width.equalTo(1)
        }
        
        activityStackView.snp.makeConstraints { (make) in
            make.top.equalTo(lineView1.snp.bottom).offset(12)
            make.trailing.equalTo(-50)
        }
        
        lineView2.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    @objc func pressCatchGuidebutton() {
        
    }
    

}
