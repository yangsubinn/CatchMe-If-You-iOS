//
//  CalendarTitleView.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/05.
//

import UIKit

import Then
import SnapKit

class CalendarTitleView: UIView {
    // MARK: - Properties
    let yearLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.textColor = .white
    }
    
    let yearTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 17, weight: .medium)
        $0.textColor = .white
        $0.text = "년"
    }
    
    let monthLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.textColor = .white
    }
    
    let monthTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 17, weight: .medium)
        $0.textColor = .white
        $0.text = "월"
    }

    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        yearLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
        }
        
        yearTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(yearLabel.snp.trailing).offset(1)
            make.bottom.equalTo(yearLabel.snp.bottom).offset(-2)
        }
        
        monthLabel.snp.makeConstraints { make in
            make.leading.equalTo(yearTitleLabel.snp.trailing).offset(5)
            make.bottom.equalTo(yearLabel.snp.bottom)
        }
        
        monthTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(monthLabel.snp.trailing).offset(1)
            make.bottom.equalTo(yearLabel.snp.bottom).offset(-2)
            make.trailing.equalToSuperview()
        }
    }
    
    // MARK: - Custom Methods
    private func configUI() {
        addSubviews([yearLabel, yearTitleLabel,
                     monthLabel, monthTitleLabel])
    }
    
    func applyYearLabel(to year: String) {
        yearLabel.text = year
    }
    
    func applyMonthLabel(to month: String) {
        monthLabel.text = month
    }
}
