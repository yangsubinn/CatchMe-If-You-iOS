//
//  EditNicknameVC.swift
//  CatchMe
//
//  Created by 양수빈 on 2021/07/10.
//

import UIKit

import SnapKit

class EditNicknameVC: UIViewController {
    // MARK: - Lazy Properties
    lazy var backButton = BackButton(self)
    
    // MARK: - Properties
    let titleLabel = UILabel()
    let nicknameTextField = CustomTextField(placeholder: "변경할 닉네임 입력")
    let removeButton = UIButton()
    let countLabel = UILabel()
    let editButton = BottomButton(title: "변경하기")
    
    var textCount = 0
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configUI()
    }
    
    // MARK: - Custom Method
    func setupLayout() {
        view.addSubviews([backButton, titleLabel, nicknameTextField,
                          countLabel, editButton, removeButton])
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(55)
            make.leading.equalToSuperview().offset(14)
            make.width.height.equalTo(48)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(37)
            make.leading.equalToSuperview().offset(28)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(28)
            make.width.equalTo(319)
        }
        
        removeButton.snp.makeConstraints { make in
            make.trailing.equalTo(nicknameTextField.snp.trailing)
            make.centerY.equalTo(nicknameTextField.snp.centerY)
            make.width.height.equalTo(48)
        }
        
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(1)
            make.leading.trailing.equalToSuperview().inset(29)
        }
        
        editButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(319)
            make.bottom.equalToSuperview().inset(50)
        }
    }
    
    func configUI() {
        view.backgroundColor = .black100
        
        titleLabel.text = "닉네임 변경"
        titleLabel.textColor = .white
        titleLabel.font = .stringMediumSystemFont(ofSize: 20)
        
        countLabel.textAlignment = .right
        countLabel.font = .numberRegularSystemFont(ofSize: 14)
        countLabel.textColor = .gray
        countLabel.isHidden = true
        
        nicknameTextField.delegate = self
        nicknameTextField.addTarget(self, action: #selector(textDidChanged(_:)), for: .editingChanged)
        
        editButton.backgroundColor = .gray200
//        editButton.changeBottomButton(isEnable: false)
//        editButton.isEnabled = false
        
        removeButton.backgroundColor = .blue
        removeButton.isHidden = true
        removeButton.addTarget(self, action: #selector(removeButtonClicked), for: .touchUpInside)
        
        hideKeyboardWhenTappedAround()
    }
    
    @objc func removeButtonClicked() {
        nicknameTextField.text = ""
        nicknameTextField.delegate = self
        // button 누르면 내용지워지면서 키보드가 내려가는데, 키보드는 안내려가게 할 수 없나
    }
}

// MARK: - UITextFieldDelegate
extension EditNicknameVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textfield: UITextField) {
        textfield.becomeFirstResponder()
        self.nicknameTextField.setupPinkLine()
        
        countLabel.isHidden = false
        removeButton.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.nicknameTextField.setupOriginalLine()
        
        if !nicknameTextField.hasText {
            countLabel.isHidden = true
            removeButton.isHidden = true
            editButton.changeBottomButton(isEnable: false)
        } else {
            editButton.changeBottomButton(isEnable: true)
            // textfield에 글자가 있으면 bottombutton 사용가능하게
        }
    }
    
    @objc func textDidChanged(_ textField: UITextField) {
        textCount = nicknameTextField.text?.count ?? 0
        
        switch textCount {
        case 0:
            countLabel.text = "0/8"
            countLabel.textColor = .gray200
        case 8:
            let attributedStr = NSMutableAttributedString(string: "8/8")
            attributedStr.addAttribute(.foregroundColor, value: UIColor.systemPink, range: ("8/8" as NSString).range(of: "8/8"))
            countLabel.attributedText = attributedStr
            editButton.changeBottomButton(isEnable: true)
        default:
            let attributedStr = NSMutableAttributedString(string: "\(textCount)/8")
            attributedStr.addAttribute(.foregroundColor, value: UIColor.systemPink, range: ("\(textCount)/8" as NSString).range(of: "\(textCount)"))
            countLabel.attributedText = attributedStr
        }
        
        checkMaxLength(textField: nicknameTextField, maxLength: 8)
    }
    
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (textField.text?.count ?? 0 > maxLength) {
            textField.deleteBackward()
        }
    }
}
