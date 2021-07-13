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
    // MARK: - Data
    var yearList: [String] = ["2021년"]
    var monthList: [String] = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
    var dayList: [String] = ["2일"]
    
    // MARK: - Properties
    let closeButton = UIButton().then {
        //        $0.setImage(UIImage(named: ""), for: .normal)
        $0.backgroundColor = .blue
    }
    
    let checkButton = UIButton().then {
        //        $0.setImage(UIImage(named: ""), for: .normal)
        $0.backgroundColor = .blue
//        $0.addTarget(self, action: #selector(touchupCloseButton(_:)), for: .touchUpInside)
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
    
    
//    let datePicker = UIDatePicker().then {
//        $0.preferredDatePickerStyle = .wheels
////        $0.maximumDate =
//
//        $0.datePickerMode = .date
//        $0.locale = Locale(identifier: "ko_KR")
//    }
    
    var viewController = UIViewController()
    
    // MARK: - Lifecycle
    init(vc: UIViewController) {
        super.init(frame: .zero)
        viewController = vc
        configUI()
        setupAutoLayout()
        setupPickerView()
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
        addSubviews([closeButton, checkButton, selectLineView, datePickerView])
        
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
            make.centerX.equalTo(datePickerView.snp.centerX)
            make.width.equalTo(275)
            make.height.equalTo(38)
        }
        
        datePickerView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(60)
            make.leading.equalToSuperview().inset(36)
            make.bottom.equalTo(self.snp.bottom).inset(24)
            make.trailing.equalTo(self.snp.trailing).inset(35)
            make.centerX.equalToSuperview()
            make.width.equalTo(230)
            make.height.equalTo(169)
        }
    }

    func setupPickerView() {
        datePickerView.delegate = self
        datePickerView.dataSource = self
    }
    
    // MARK: - @objc
    
}

// MARK: - UIPickerViewDelegate
extension AddActionDatePickerPopupView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 38
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        return view
        
        var textView = view as? UITextView
        if textView == nil {
            textView = UITextView()
            textView?.font = UIFont.numberMediumSystemFont(ofSize: 22)
            textView?.textAlignment = .left
        }
//
//        var unitView = view as? UITextView
//        if unitView == nil {
//            unitView = UITextView()
//            unitView?.font = UIFont.numberMediumSystemFont(ofSize: 22)
//            unitView?.textAlignment = .left
//        }
        
        textView?.text = "\(self.yearList[row])"
        
        return textView!
    }
}

// MARK: - UIPickerViewDataSource
extension AddActionDatePickerPopupView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 6
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return yearList.count
        case 1: return 1
        case 2: return monthList.count
        case 3: return 1
        case 4: return dayList.count
        default: return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0: return yearList[row]
        case 1: return "년"
        case 2: return monthList[row]
        case 3: return "월"
        case 4: return dayList[row]
        default: return "일"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0: return print("select=\(yearList[row])")
        case 1: return print("select=\(monthList[row])")
        case 2: return print("select=\(dayList[row])")
        default: break
        }
//        pickerView.subviews.first?.subviews.last?.backgroundColor = .none
        
    }
    
    
}
