//
//  SecondFlowView.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/08.
//

import UIKit

import SnapKit

class SecondFlowView: UIView {
    // MARK: - Properties
    let titleView = CatchuTitleView(title: "하나뿐인 내 캐츄의 이름은?", subTitle: "나의 캐츄를 대표할 이름을 지어주세요")
    let characterImageView = UIImageView(image: UIImage(named: ""))
    let textField = CustomTextField(placeholder: "캐츄 이름 입력")
    let recommendLabel = UILabel()
    let countLabel = UILabel()
    
    var textCount = 0
    
    // MARK: - Dummy Data
    /// 후에 enum으로 사용하면 편리할 듯 -> 아니면 public하게 전체적으로 사용할 수 있도록 만들기
    let colors: [UIColor] = [.systemRed, .systemBlue, .systemPink, .systemTeal, .systemGray, .systemGreen, .systemOrange, .systemYellow, .systemPurple, .systemIndigo]
    let recommends: [String] = ["‘___없이 못사는 ___러버’", "‘___랑 함께사는 ___집사’", "‘___만 먹는 ___중독자’", "‘___를 하루종일 하는 ___러버’", "‘___이 너무 재밌는 ___처돌이’", "‘당장 ___하고픈 ___중독자’"]
    var randomIndex = Int.random(in: 0...5)

    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Methods
    private func setupLayout() {
        addSubviews([titleView, characterImageView,
                     textField, recommendLabel, countLabel])
        
        titleView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(28)
        }
        
        characterImageView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(UIScreen.main.hasNotch ? 175 : 115)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(150)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(characterImageView.snp.bottom).offset(UIScreen.main.hasNotch ? 74 : 40)
            make.leading.trailing.equalToSuperview().inset(28)
        }
        
        recommendLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(45)
        }
        
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(4)
            make.trailing.equalToSuperview().inset(28)
        }
    }
    
    private func configUI() {
        textField.delegate = self
        textField.addTarget(self, action: #selector(textDidChanged(_:)), for: .editingChanged)
        
        recommendLabel.font = .systemFont(ofSize: 12)
        recommendLabel.textColor = .gray400
        recommendLabel.text = "캐치미 추천: " + recommends[randomIndex]
        
        countLabel.textAlignment = .right
        countLabel.isHidden = true
        countLabel.textColor = .gray200
        countLabel.font = .systemFont(ofSize: 14)
        countLabel.text = "\(textCount)/20"
    }
    
    func setImageViewColor(selectedIndex: Int) {
        characterImageView.backgroundColor = colors[selectedIndex]
    }
}

// MARK: - UITextFieldDelegate
extension SecondFlowView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        
        self.textField.setupPinkLine()
        
        UIView.animate(withDuration: 0.2, animations: {
            self.characterImageView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.hasNotch ? -74 : -50)
            textField.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.hasNotch ? -122 : -65)
            self.countLabel.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.hasNotch ? -122 : -65)
        })
        
        recommendLabel.isHidden = true
        countLabel.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.textField.setupOriginalLine()
        if !textField.hasText {
            recommendLabel.isHidden = false
            countLabel.isHidden = true
        }
    }
    
    @objc
    func textDidChanged(_ sender: Any) {
        textCount = textField.text?.count ?? 0
        
        switch textCount {
        case 0:
            countLabel.text = "0/20"
            countLabel.textColor = .gray200
        case 20:
            let attributedStr = NSMutableAttributedString(string: "20/20")
            attributedStr.addAttribute(.foregroundColor, value: UIColor.systemPink, range: ("20/20" as NSString).range(of: "20/20"))
            countLabel.attributedText = attributedStr
        default:
            let attributedStr = NSMutableAttributedString(string: "\(textCount)/20")
            attributedStr.addAttribute(.foregroundColor, value: UIColor.systemPink, range: ("\(textCount)/20" as NSString).range(of: "\(textCount)"))
            countLabel.attributedText = attributedStr
        }
        
        checkMaxLength(textField: textField, maxLength: 20)
    }
    
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (textField.text?.count ?? 0 > maxLength) {
            textField.deleteBackward()
        }
    }
}
