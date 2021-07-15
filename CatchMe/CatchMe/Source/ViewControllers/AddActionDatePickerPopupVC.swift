//
//  AddActionDatePickerPopupVC.swift
//  CatchMe
//
//  Created by Thisisme Hi on 2021/07/13.
//

import UIKit

import SnapKit

class AddActionDatePickerPopupVC: UIViewController {
    // MARK: - lazy Properties
    lazy var popupView = AddActionDatePickerPopupView(vc: self)

    // MARK: - Properties
    var sendData: ((String?) -> ())?
    var selectedDate: String?

    let vc = AddActionVC()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
    }
    
    // MARK: - Custom Method
    private func configUI() {
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)
        
        popupView.closeButton.addTarget(self, action: #selector(touchupCloseButton(_:)), for: .touchUpInside)
        popupView.checkButton.addTarget(self, action: #selector(touchupCheckButton(_:)), for: .touchUpInside)
        popupView.datePicker.addTarget(self, action: #selector(changed), for: .valueChanged)
    }
    
    private func setupLayout() {
        view.addSubview(popupView)
        
        let height = UIScreen.main.bounds.size.height / 667
        
        popupView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).inset(UIScreen.main.bounds.size.height * 0.32)
            make.centerX.equalToSuperview()
            make.width.equalTo(301 * (UIScreen.main.bounds.size.width / 375))
            make.height.equalTo(height == 1 ? 253 : (253 * height) * 0.85)
        }
    }
    
    // MARK: - @objc
    @objc func changed() {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .long
        dateformatter.timeStyle = .none
        dateformatter.locale = Locale(identifier: "ko_KR")
        dateformatter.dateFormat = "yyyy.MM.dd"
        
        var components = DateComponents()
        components.year = -20
        let minDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: Date())
        popupView.datePicker.minimumDate = minDate
        
        let date = dateformatter.string(from: popupView.datePicker.date)
        selectedDate = date
        print(selectedDate)
    }
    
    @objc func touchupCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func touchupCheckButton(_ sender: UIButton) {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let dateString = dateFormatter.string(from: now)
        sendData?(selectedDate ?? dateString)
        self.dismiss(animated: true, completion: nil)
    }
}
