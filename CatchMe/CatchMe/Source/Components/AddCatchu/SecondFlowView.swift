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
    let characterImageView = UIImageView()
    let textField = CustomTextField(placeholder: "캐츄 이름 입력", isAddCatchu: true, small: true)
    let recommendLabel = UILabel()
    let countLabel = UILabel()
    
    var textCount = 0
    var randomIndex = Int.random(in: 0...5)
    let recommends: [String] = ["___없이 못사는 몰랑이",
                                "최근 ___에 빠져버린 회원님",
                                "숨만 쉬고 ____만 하는 후후하하",
                                "눈뜨면 ____부터 하는 병아리",
                                "자기 전에 무조건 ___ 하고 자는 북극곰",
                                "세상에서 제일 가는 ___러버",
                                "___에 미친 개구쟁이",
                                "자기전까지 ___만 생각하는 잠만보",
                                "____에 미친 판다",
                                "꿈에서도 ___만 생각하는 꾸물이",
                                "나는야 ___ 제일 좋아",
                                "머릿속에 온통 ___ 생각뿐인 런닝맨"]
    let babyCatchus: [UIImage?] = [Character.green.getCharacterImage(phase: 1, size: 151),
                                   Character.yellowGreen.getCharacterImage(phase: 1, size: 151),
                                   Character.orange.getCharacterImage(phase: 1, size: 151),
                                   Character.blue.getCharacterImage(phase: 1, size: 151),
                                   Character.purple.getCharacterImage(phase: 1, size: 151),
                                   Character.skyblue.getCharacterImage(phase: 1, size: 151),
                                   Character.yellow.getCharacterImage(phase: 1, size: 151),
                                   Character.white.getCharacterImage(phase: 1, size: 151)]

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
            make.top.equalTo(titleView.snp.bottom).offset(UIScreen.main.hasNotch ? 162.5 : 102.5)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(175)
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
        
        recommendLabel.font = .stringRegularSystemFont(ofSize: 12)
        recommendLabel.textColor = .gray400
        recommendLabel.text = "캐치미 추천: " + recommends[randomIndex]
        recommendLabel.addCharacterSpacing()
        
        countLabel.textAlignment = .right
        countLabel.isHidden = true
        countLabel.textColor = .gray200
        countLabel.font = .numberRegularSystemFont(ofSize: 14)
        countLabel.text = "\(textCount)/20"
    }
    
    // MARK: - external use function
    func setImageViewColor(selectedIndex: Int) {
        characterImageView.image = babyCatchus[selectedIndex]
    }
}

// MARK: - UITextFieldDelegate
extension SecondFlowView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        self.textField.setupPinkLine()
        
        recommendLabel.isHidden = true
        countLabel.isHidden = false
        
        UIView.animate(withDuration: 0.2, animations: {
            self.characterImageView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.hasNotch ? -74 : -50)
            textField.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.hasNotch ? -122 : -75)
            self.countLabel.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.hasNotch ? -122 : -75)
        })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.textField.setupOriginalLine()
        
        if !textField.hasText {
            recommendLabel.isHidden = false
            countLabel.isHidden = true
        }
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
        textCount = textField.text?.count ?? 0
        
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
        
        checkMaxLength(textField: textField, maxLength: 20)
    }
    
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (textField.text?.count ?? 0 > maxLength) {
            textField.deleteBackward()
        }
    }
}
