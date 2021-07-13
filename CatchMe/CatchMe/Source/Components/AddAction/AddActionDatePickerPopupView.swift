//
//  AddActionDatePickerPopupView.swift
//  CatchMe
//
//  Created by Thisisme Hi on 2021/07/13.
//

import UIKit

import Then
import SnapKit

class AddActionDatePickerPopupView: UIView {
    // MARK: - Properties
    let closeButton = UIButton().then {
        //        $0.setImage(UIImage(named: ""), for: .normal)
        $0.backgroundColor = .blue
    }
    
    let checkButton = UIButton().then {
        //        $0.setImage(UIImage(named: ""), for: .normal)
        $0.backgroundColor = .blue
    }
    
    let selectLineView = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.pink100.cgColor
        $0.layer.cornerRadius = 13
        $0.makeShadow(.black, 0.25, CGSize(width: 0, height: 4), 4)
    }
    
    let datePickerView = UIPickerView().then {
        $0.subviews.first?.subviews.last?.backgroundColor = .none
    }
    
    let datePicker = UIDatePicker().then {
        $0.datePickerMode = .date
        $0.preferredDatePickerStyle = .wheels
        $0.locale = Locale(identifier: "ko_KR")
        $0.addTarget(self, action: #selector(changed), for: .valueChanged)
        $0.setValue(UIColor.white, forKeyPath: "textColor")
    }
    
    var viewController = UIViewController()
    
    // MARK: - Lifecycle
    init(vc: UIViewController) {
        super.init(frame: .zero)
        viewController = vc
        configUI()
        setupAutoLayout()
    }
    
    override func layoutSubviews() {
        datePicker.subviews[0].subviews[1].isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    func configUI() {
        backgroundColor = .black200
        layer.cornerRadius = 18
    }
    
    func setupAutoLayout() {
        addSubviews([closeButton, checkButton, datePicker])
        datePicker.addSubview(selectLineView)
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(8)
            make.leading.equalTo(self.snp.leading).inset(8)
            make.width.height.equalTo(48)
        }
        
        checkButton.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(8)
            make.trailing.equalTo(self.snp.trailing).inset(8)
            make.width.height.equalTo(48)
        }
        
        selectLineView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(126)
            make.centerX.equalTo(datePicker.snp.centerX)
            make.width.equalTo(275)
            make.height.equalTo(38)
        }
        
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(UIScreen.main.hasNotch ? 53 : 60)
            make.bottom.equalTo(self.snp.bottom).inset(24)
            make.centerX.equalToSuperview()
            make.height.equalTo(169)
            
            var components = DateComponents()
            components.day = 10
            let maxDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: Date())
            components.day = -10
            let minDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: Date())

            datePicker.maximumDate = maxDate
            datePicker.minimumDate = minDate
        }
    }
    
    // MARK: - @objc
    @objc func changed() {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .long
        dateformatter.timeStyle = .none
    }
}
