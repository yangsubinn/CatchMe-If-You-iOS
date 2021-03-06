//
//  TitleView.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/05.
//

import UIKit

import Then
import SnapKit

class TitleView: UIView {
    // MARK: - Properties
    let nicknameLabel = UILabel().then {
        $0.font = .stringBoldSystemFont(ofSize: 22)
        $0.textColor = .white
    }
    
    let postpositionLabel = UILabel().then {
        $0.font = .stringMediumSystemFont(ofSize: 18)
        $0.textColor = .white
        $0.text = "님의"
    }
    
    let monthLabel = UILabel().then {
        $0.font = .stringMediumSystemFont(ofSize: 17)
        $0.textColor = .white
    }
    
    let dateformatter = DateFormatter()

    // MARK: - Life Cycle
    init(nickname: String) {
        super.init(frame: .zero)
        configUI(nickname: nickname)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        monthLabel.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        postpositionLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.bottom.equalTo(monthLabel.snp.top).offset(-3)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.trailing.equalTo(postpositionLabel.snp.leading).offset(-3)
            make.bottom.equalTo(monthLabel.snp.top).offset(-3)
        }
    }
    
    // MARK: - Custom Method
    private func configUI(nickname: String) {
        addSubviews([nicknameLabel, postpositionLabel, monthLabel])
        
        nicknameLabel.text = nickname
        monthLabel.text = " 월" + " 가장 많이 잡은 캐츄는"
    }
    
    func applyMonthLabel(to month: String){
        let monthString = month + "월"
        monthLabel.text = monthString + " 가장 많이 잡은 캐츄는"
    }
}
