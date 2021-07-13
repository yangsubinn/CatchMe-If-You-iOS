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
    lazy var nicknameTextField = CustomTextField(placeholder: currentNickname)
    
    // MARK: - Properties
    let titleLabel = UILabel()
    let removeButton = UIButton()
    let countLabel = UILabel()
    let editButton = BottomButton(title: "완료")
    
    var textCount = 0
    
    // MARK: - Dummy Data
    var currentNickname = "괜찮아도 괜찮아"
    
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
            make.leading.trailing.equalToSuperview().inset(28)
        }
        
        removeButton.snp.makeConstraints { make in
            make.trailing.equalTo(nicknameTextField.snp.trailing)
            make.centerY.equalTo(nicknameTextField.snp.centerY)
            make.width.height.equalTo(48)
        }
        
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(1)
            make.trailing.equalTo(nicknameTextField.snp.trailing).offset(-1)
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
        titleLabel.addCharacterSpacing()
        
        countLabel.textAlignment = .right
        countLabel.font = .numberRegularSystemFont(ofSize: 14)
        countLabel.text = "0/10"
        countLabel.textColor = .gray
        countLabel.isHidden = true
        
        nicknameTextField.delegate = self
        nicknameTextField.addTarget(self, action: #selector(textDidChanged(_:)), for: .editingChanged)
        nicknameTextField.tintColor = .pink100
        nicknameTextField.font = .stringRegularSystemFont(ofSize: 18)
        nicknameTextField.setRightPaddingPoints(48)
        
        editButton.backgroundColor = .gray200
        editButton.isEnabled = false

        removeButton.setImage(UIImage(named: "btnRemove"), for: .normal)
        removeButton.isHidden = true
        removeButton.addTarget(self, action: #selector(removeButtonClicked), for: .touchUpInside)
        
        hideKeyboardWhenTappedAround()
    }
    
    @objc
    func removeButtonClicked() {
        nicknameTextField.text = ""
        countLabel.text = "0/10"
        // count 고쳐라
        
        if !nicknameTextField.isEditing {
            countLabel.isHidden = true
            removeButton.isHidden = true
        }
    }
    
    @objc
    override func dismissKeyboard() {
        if !removeButton.isTouchInside {
            view.endEditing(true)
        }
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
        
        countLabel.isHidden = true
        
        if !nicknameTextField.hasText {
            removeButton.isHidden = true
            editButton.isEnabled = false
            editButton.backgroundColor = .gray200
        } else {
            editButton.changeBottomButton(isEnable: true)
            editButton.isEnabled = true
            editButton.backgroundColor = .pink100
        }
    }
    
    @objc func textDidChanged(_ textField: UITextField) {
        textCount = nicknameTextField.text?.count ?? 0
        
        switch textCount {
        case 0:
            countLabel.text = "0/10"
            countLabel.textColor = .gray200
        case 10:
            let attributedStr = NSMutableAttributedString(string: "10/10")
            attributedStr.addAttribute(.foregroundColor, value: UIColor.red100, range: ("10/10" as NSString).range(of: "10/10"))
            countLabel.attributedText = attributedStr
            editButton.changeBottomButton(isEnable: true)
        default:
            let attributedStr = NSMutableAttributedString(string: "\(textCount)/10")
            attributedStr.addAttribute(.foregroundColor, value: UIColor.pink210, range: ("\(textCount)/10" as NSString).range(of: "\(textCount)"))
            countLabel.attributedText = attributedStr
        }
        
        checkMaxLength(textField: nicknameTextField, maxLength: 10)
    }
    
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (textField.text?.count ?? 0 > maxLength) {
            textField.deleteBackward()
        }
    }
}
