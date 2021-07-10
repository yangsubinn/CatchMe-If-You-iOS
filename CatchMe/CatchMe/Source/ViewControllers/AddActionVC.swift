//
//  AddActionVC.swift
//  CatchMe
//
//  Created by Thisisme Hi on 2021/07/07.
//

import UIKit

import Then
import SnapKit

class AddActionVC: UIViewController {
    // MARK: - Properties
    let pinkBackgroundView = UIView().then {
        $0.backgroundColor = .pink100
    }
    
    let dateLabel = UILabel().then {
        $0.text = "2021.05.01"
        $0.font = .numberRegularSystemFont(ofSize: 17)
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    let dateButton = UIButton().then {
//        $0.setImage(UIImage(named: ""), for: .normal)
        $0.backgroundColor = . white
    }
    
    lazy var closeButton = XmarkButton(self)

    let nameLabel = UILabel().then {
        $0.text = "한둘셋넷다여일여아열\n한둘셋넷다여일여아열"
        $0.font = .catchuRegularSystemFont(ofSize: 21)
        $0.textAlignment = .left
        $0.textColor = .white
        $0.numberOfLines = 2
        $0.lineBreakMode = .byWordWrapping
        
        let attributedString = NSMutableAttributedString(string: $0.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        $0.attributedText = attributedString
    }
    
    let catchuImageView = UIImageView().then {
//        $0.image = UIImage(named: "")
        $0.backgroundColor = .orange
    }
    
    let radiusImageView = UIImageView().then {
//        $0.setImage(UIImage(named: "imgScroll"), for: .normal)
        $0.backgroundColor = .yellow
    }
    
    let blackBackgroundView = UIView().then {
        $0.backgroundColor = .black100
    }
    
    let activityLabel = UILabel().then {
        $0.text = "활동 입력*"
        $0.font = .stringMediumSystemFont(ofSize: 18)
        $0.textAlignment = .left
        $0.textColor = .white
        
        let attributedString = NSMutableAttributedString(string: $0.text!)
        attributedString.addAttribute(.foregroundColor, value: UIColor.pink100, range: ($0.text! as NSString).range(of:"*"))
        $0.attributedText = attributedString
    }
    
    let activityTextView = UITextView().then {
        $0.backgroundColor = .black200
        $0.layer.cornerRadius = 13
        $0.font = .stringRegularSystemFont(ofSize: 14)
        $0.textColor = .white
        $0.textAlignment = .left
        
        let attributedString = NSMutableAttributedString(string: $0.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        $0.attributedText = attributedString
    }
    
    let letterNumLabel = UILabel().then {
        $0.text = "0/150"
        $0.font = .numberRegularSystemFont(ofSize: 14)
        $0.textColor = .gray200
        $0.textAlignment = .right
    }
    
    let addPhotoLabel = UILabel().then {
        $0.text = "사진 추가"
        $0.font = .stringMediumSystemFont(ofSize: 18)
        $0.textAlignment = .left
        $0.textColor = .white
    }
    
    let photoButton = UIButton().then {
//        $0.setImage(UIImage(named: ""), for: .normal)
        $0.layer.cornerRadius = 13
        $0.backgroundColor = .orange
    }
    
    let removeButton = UIButton().then {
//        $0.setImage(UIImage(named: ""), for: .normal)
        $0.backgroundColor = .yellow
    }
    
    let uploadButton = BottomButton(title: "기록하기")
        
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupAutoLayout()
    }
    
    // MARK: - Custom Method
    func configUI() {
        view.backgroundColor = .black100
    }
    
    func setupAutoLayout() {
        view.addSubviews([blackBackgroundView, pinkBackgroundView, radiusImageView,
                          catchuImageView, dateLabel, dateButton,
                          closeButton, nameLabel])
        blackBackgroundView.addSubviews([activityLabel, activityTextView, letterNumLabel,
                                         addPhotoLabel, photoButton, removeButton, uploadButton])
        
        pinkBackgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(228)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).inset(UIScreen.main.hasNotch ? 55 : 41)
            make.trailing.equalTo(view.snp.trailing).inset(UIScreen.main.hasNotch ? 14 : 4)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).inset(UIScreen.main.hasNotch ? 86 : 75)
            make.leading.equalTo(view.snp.leading).inset(UIScreen.main.hasNotch ? 28 : 19)
        }
        
        dateButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).inset(73)
            make.leading.equalTo(dateLabel.snp.trailing).offset(-10)
            make.width.height.equalTo(48)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(17)
            make.leading.equalTo(view.snp.leading).inset(28)
        }
        
        catchuImageView.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(6)
            make.trailing.equalTo(view.snp.trailing).inset(28)
            make.width.height.equalTo(130)
        }
        
        radiusImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalTo(pinkBackgroundView.snp.bottom)
            make.height.equalTo(36)
        }
        
        blackBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(radiusImageView.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
        }
        
        activityLabel.snp.makeConstraints { make in
            make.top.equalTo(radiusImageView.snp.bottom)
            make.leading.equalTo(view.snp.leading).inset(28)
        }
        
        activityTextView.snp.makeConstraints { make in
            make.top.equalTo(activityLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(28)
            make.height.equalTo(190)
        }
        
        letterNumLabel.snp.makeConstraints { make in
            make.top.equalTo(activityTextView.snp.bottom).offset(4)
            make.trailing.equalTo(view.snp.trailing).inset(28)
        }
        
        addPhotoLabel.snp.makeConstraints { make in
            make.top.equalTo(activityTextView.snp.bottom).offset(38)
            make.leading.equalTo(view.snp.leading).inset(28)
        }
        
        photoButton.snp.makeConstraints { make in
            make.top.equalTo(addPhotoLabel.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).inset(28)
            make.width.equalTo(124)
            make.height.equalTo(92)
        }
        
        removeButton.snp.makeConstraints { make in
            make.top.equalTo(photoButton.snp.top).offset(-21)
            make.trailing.equalTo(photoButton.snp.trailing).offset(21)
            make.width.height.equalTo(48)
        }
        
        uploadButton.snp.makeConstraints { make in
            make.top.equalTo(photoButton.snp.bottom).offset(58)
            make.leading.trailing.equalToSuperview().inset(28)
        }
    }
}