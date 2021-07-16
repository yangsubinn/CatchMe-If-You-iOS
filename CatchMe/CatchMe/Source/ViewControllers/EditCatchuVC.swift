//
//  EditCatchuVC.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/13.
//

import UIKit

import SnapKit

class EditCatchuVC: UIViewController {
    // MARK: - Lazy Properties
    lazy var navigationBar = CustomNavigationBar(self, title: "캐츄 수정")
    lazy var textCount = characterName.count
    lazy var currentLock = isLock
    
    // MARK: - Properties
    let backgroundImageView = UIImageView()
    let characterImageView = UIImageView()
    let nameLabel = UILabel()
    let lockLabel = UILabel()
    let countLabel = UILabel()
    let lockButton = UIButton()
    let nameTextField = CustomTextField(placeholder: "캐츄 이름 입력", isAddCatchu: true, small: true)
    let editButton = BottomButton(title: "변경하기")
    let height = UIApplication.statusBarHeight
    
    var isLock = true
    
    // MARK: - Server Data
    let viewModel = CharacterViewModel.shared
    var characterName: String = ""
    var characterIndex: Int = 4
    var colors: [UIColor] = [.back300, .back300, .back200, .back400, .back100, .back400, .back200, .back100]

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configUI()
        setCountLabel()
        setupButtonAction()
    }
    
    // MARK: - Custom Method
    private func setupLayout() {
        view.addSubviews([navigationBar, backgroundImageView, characterImageView,
                          nameLabel, nameTextField, lockLabel, lockButton,
                          editButton, countLabel])
        
        navigationBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(59 + height)
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(125)
        }
        
        characterImageView.snp.makeConstraints { make in
            make.center.equalTo(backgroundImageView.snp.center)
            make.height.width.equalTo(101)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView.snp.bottom).offset(40)
            make.leading.equalToSuperview().inset(30)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(28)
        }
        
        lockButton.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(28)
            make.leading.equalToSuperview().inset(22)
            make.height.width.equalTo(34)
        }
        
        lockLabel.snp.makeConstraints { make in
            make.centerY.equalTo(lockButton.snp.centerY)
            make.leading.equalTo(lockButton.snp.trailing).offset(8)
        }
        
        editButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(50)
            make.leading.trailing.equalToSuperview().inset(28)
        }
        
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(4)
            make.trailing.equalToSuperview().inset(28)
        }
    }
    
    private func configUI() {
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = .black100
        
        backgroundImageView.layer.cornerRadius = 125/2
        backgroundImageView.backgroundColor = colors[characterIndex-1]
        
        characterImageView.image = Character.blue.getCharacterImage(phase: 1, size: 101)
        
        nameLabel.text = "이름 변경"
        nameLabel.font = .stringMediumSystemFont(ofSize: 18)
        nameLabel.addCharacterSpacing()
        
        nameTextField.tintColor = .pink100
        nameTextField.text = characterName
        nameTextField.delegate = self
        nameTextField.addTarget(self, action: #selector(textDidChanged(_:)), for: .editingChanged)
        
        lockLabel.text = "다른 사용자에게 공개할래요"
        lockLabel.font = .stringRegularSystemFont(ofSize: 14)
        lockLabel.addCharacterSpacing()
        lockLabel.textColor = .white
        
        lockButton.setImage(UIImage(named: isLock ? "checkboxActive" : "checkboxInactive"), for: .normal)
        
        editButton.backgroundColor = .gray300
        editButton.isEnabled = false
    }
    
    private func setCountLabel() {
        countLabel.isHidden = true
        countLabel.font = .numberRegularSystemFont(ofSize: 14)
        countLabel.addCharacterSpacing(kernValue: -0.08, paragraphValue: 4)
        countLabel.textAlignment = .right
        
        switch characterName.count {
        case 0:
            countLabel.text = "0/20"
            countLabel.textColor = .gray200
        case 20:
            let attributedStr = NSMutableAttributedString(string: "20/20")
            attributedStr.addAttribute(.foregroundColor, value: UIColor.pink100, range: ("20/20" as NSString).range(of: "20/20"))
            countLabel.attributedText = attributedStr
        default:
            let attributedStr = NSMutableAttributedString(string: "\(characterName.count)/20")
            attributedStr.addAttribute(.foregroundColor, value: UIColor.pink100, range: ("\(characterName.count)/20" as NSString).range(of: "\(characterName.count)"))
            countLabel.attributedText = attributedStr
        }
    }
    
    private func setupButtonAction() {
        let lockAction = UIAction { _ in
            self.lockButton.setImage(self.isLock ? UIImage(named: "checkboxInactive") : UIImage(named: "checkboxActive"), for: .normal)
            self.lockLabel.textColor = self.isLock ? .gray400 : .white
            
            if (self.nameTextField.text == self.characterName) && self.nameTextField.hasText {
                if self.currentLock == !self.isLock {
                    self.editButton.backgroundColor = .gray300
                    self.editButton.isEnabled = false
                } else {
                    self.editButton.backgroundColor = .pink100
                    self.editButton.isEnabled = true
                }
            }
            
            self.isLock.toggle()
        }
        lockButton.addAction(lockAction, for: .touchUpInside)
        
        let editAction = UIAction { _ in
            print("edit")
            if let text = self.nameTextField.text {
                self.viewModel.dispatchCharacterEdit(name: text, index: self.characterIndex, privacy: self.isLock, vc: self)
            }
        }
        editButton.addAction(editAction, for: .touchUpInside)
    }
}

// MARK: - UITextFieldDelegate
extension EditCatchuVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        nameTextField.setupPinkLine()
        
        countLabel.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        nameTextField.setupOriginalLine()
        
        countLabel.isHidden = true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        /// 이모지 입력 금지
        let utf8Char = string.cString(using: .utf8)
        let isBackSpace = strcmp(utf8Char, "\\b")
        
        if string.hasCharacters() || isBackSpace == -92 {
            return true
        }
        
        return false
    }
    
    @objc
    func textDidChanged(_ sender: Any) {
        /// 변경하기 부분
        if nameTextField.text != characterName && nameTextField.hasText {
            editButton.backgroundColor = .pink100
            editButton.isEnabled = true
        } else {
            if nameTextField.text == characterName && currentLock != isLock {
                editButton.backgroundColor = .pink100
                editButton.isEnabled = true
            } else {
                editButton.backgroundColor = .gray300
                editButton.isEnabled = false
            }
        }
        
        /// textCount count
        textCount = nameTextField.text?.count ?? 0
        
        switch textCount {
        case 0:
            countLabel.text = "0/20"
            countLabel.textColor = .gray200
        case 20:
            let attributedStr = NSMutableAttributedString(string: "20/20")
            attributedStr.addAttribute(.foregroundColor, value: UIColor.pink100, range: ("20/20" as NSString).range(of: "20/20"))
            countLabel.attributedText = attributedStr
        default:
            let attributedStr = NSMutableAttributedString(string: "\(textCount)/20")
            attributedStr.addAttribute(.foregroundColor, value: UIColor.pink100, range: ("\(textCount)/20" as NSString).range(of: "\(textCount)"))
            countLabel.attributedText = attributedStr
        }
        
        checkMaxLength(textField: nameTextField, maxLength: 20)
    }
    
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (textField.text?.count ?? 0 > maxLength) {
            textField.deleteBackward()
        }
    }
    
    @objc
    override func dismissKeyboard() {
        if !lockButton.isTouchInside {
            view.endEditing(true)
        }
    }
}
