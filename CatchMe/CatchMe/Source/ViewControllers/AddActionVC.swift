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
    var keyHeight = CGFloat()
    
    let placholder: String = "(예 : 오늘 아침에 일어나서 중랑천 2.5km 뛰었음)"
    
    let imagePicker = UIImagePickerController()
    
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
    
    let closeButton = UIButton().then {
        //        $0.setImage(UIImage(named: ""), for: .normal)
        $0.backgroundColor = .blue
        $0.addTarget(self, action: #selector(touchupCloseButton(_:)), for: .touchUpInside)
    }
    
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
        $0.textAlignment = .left
        $0.tintColor = .pink100
        $0.textContainerInset = UIEdgeInsets(top: UIScreen.main.hasNotch ? 18 : 11, left: UIScreen.main.hasNotch ? 18 : 14, bottom: UIScreen.main.hasNotch ? 13 : 6, right: UIScreen.main.hasNotch ? 19 : 8)
        
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
        $0.clipsToBounds = true
        $0.imageView?.contentMode = .scaleAspectFill
        $0.backgroundColor = .orange
        $0.addTarget(self, action: #selector(touchupPhotoButton(_:)), for: .touchUpInside)
    }
    
    let deletePhotoButton = UIButton().then {
        //        $0.setImage(UIImage(named: ""), for: .normal)
        $0.backgroundColor = .yellow
        $0.addTarget(self, action: #selector(touchupDeletePhotoButton(_:)), for: .touchUpInside)
    }
    
    let uploadButton = BottomButton(title: "기록하기")
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupAutoLayout()
        setupTextView()
        setupImagePicker()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Custom Method
    func configUI() {
        view.backgroundColor = .black100
        
        deletePhotoButton.isHidden = true
        
        activityTextView.text = placholder
        activityTextView.textColor = .gray200
        activityTextView.font = .stringRegularSystemFont(ofSize: 14)
        
        if activityTextView.textColor == UIColor.white {
            uploadButton.backgroundColor = .pink100
        } else if activityTextView.textColor == UIColor.gray200 {
            uploadButton.backgroundColor = .gray200
        }
    }
    
    func setupAutoLayout() {
        view.addSubviews([blackBackgroundView, pinkBackgroundView, radiusImageView,
                          catchuImageView, dateLabel, dateButton,
                          closeButton, nameLabel])
        blackBackgroundView.addSubviews([activityLabel, activityTextView, letterNumLabel,
                                         addPhotoLabel, photoButton, deletePhotoButton,
                                         uploadButton])
        
        pinkBackgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.hasNotch ? 244 : 210)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIScreen.main.hasNotch ? 55 : 41)
            make.trailing.equalTo(view.snp.trailing).inset(UIScreen.main.hasNotch ? 14 : 4)
            make.width.height.equalTo(48)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIScreen.main.hasNotch ? 86 : 75)
            make.leading.equalTo(view.snp.leading).inset(UIScreen.main.hasNotch ? 28 : 19)
        }
        
        dateButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIScreen.main.hasNotch ? 73 : 62)
            make.leading.equalTo(dateLabel.snp.trailing).offset(-10)
            make.width.height.equalTo(48)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(UIScreen.main.hasNotch ? 17 : 13)
            make.leading.equalToSuperview().inset(UIScreen.main.hasNotch ? 28 : 20)
        }
        
        catchuImageView.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(UIScreen.main.hasNotch ? 6 : -9)
            make.trailing.equalToSuperview().inset(UIScreen.main.hasNotch ? 28 : 20)
            make.width.height.equalTo(131)
        }
        
        radiusImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalTo(pinkBackgroundView.snp.bottom)
            make.height.equalTo(UIScreen.main.hasNotch ? 36 : 25)
        }
        
        blackBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(radiusImageView.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
        }
        
        activityLabel.snp.makeConstraints { make in
            make.top.equalTo(radiusImageView.snp.bottom)
            make.leading.equalToSuperview().inset(28)
        }
        
        activityTextView.snp.makeConstraints { make in
            make.top.equalTo(activityLabel.snp.bottom).offset(UIScreen.main.hasNotch ? 20 : 12)
            make.leading.trailing.equalToSuperview().inset(UIScreen.main.hasNotch ? 28 : 20)
            make.height.equalTo(UIScreen.main.hasNotch ? 190 : 176)
        }
        
        letterNumLabel.snp.makeConstraints { make in
            make.top.equalTo(activityTextView.snp.bottom).offset(4)
            make.trailing.equalToSuperview().inset(UIScreen.main.hasNotch ? 28 : 19)
        }
        
        addPhotoLabel.snp.makeConstraints { make in
            make.top.equalTo(activityTextView.snp.bottom).offset(UIScreen.main.hasNotch ? 38 : 24)
            make.leading.equalToSuperview().inset(UIScreen.main.hasNotch ? 28 : 20)
        }
        
        photoButton.snp.makeConstraints { make in
            make.top.equalTo(addPhotoLabel.snp.bottom).offset(UIScreen.main.hasNotch ? 20 : 12)
            make.leading.equalToSuperview().inset(UIScreen.main.hasNotch ? 28 : 20)
            make.width.equalTo(UIScreen.main.hasNotch ? 124 : 109)
            make.height.equalTo(UIScreen.main.hasNotch ? 92 : 81)
        }
        
        deletePhotoButton.snp.makeConstraints { make in
            make.top.equalTo(photoButton.snp.top).offset(-21)
            make.trailing.equalTo(photoButton.snp.trailing).offset(21)
            make.width.height.equalTo(48)
        }
        
        uploadButton.snp.makeConstraints { make in
            make.top.equalTo(photoButton.snp.bottom).offset(UIScreen.main.hasNotch ? 58 : 19)
            make.leading.trailing.equalToSuperview().inset(UIScreen.main.hasNotch ? 28 : 20)
        }
    }
    
    func setupTextView() {
        activityTextView.delegate = self
    }
    
    func setupImagePicker() {
        imagePicker.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.blackBackgroundView.frame.origin.y = UIScreen.main.hasNotch ? 262 : 225.5
    }
    
    func changeLetterNumLabelColor() {
        if activityTextView.text == placholder {
            letterNumLabel.textColor = .gray200
        } else {
            letterNumLabel.textColor = .pink100
            let attributedString = NSMutableAttributedString(string: letterNumLabel.text!)
            attributedString.addAttribute(.foregroundColor, value: UIColor.gray200, range: (letterNumLabel.text! as NSString).range(of:"/150"))
            letterNumLabel.attributedText = attributedString
        }
    }
    
    // MARK: - @objc
    @objc func touchupCloseButton(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "AddActionPopupVC") as? AddActionPopupVC else { return }
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func touchupPhotoButton(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func touchupDeletePhotoButton(_ sender: UIButton) {
        /// 나중에 버튼 이미지 이름 부분에 디자이너가 넘겨준 에셋을 넘겨줄 예정입니다
        photoButton.setImage(UIImage(named: ""), for: .normal)
        if photoButton.currentImage == UIImage(named: "") {
            deletePhotoButton.isHidden = true
        } else {
            deletePhotoButton.isHidden = false
        }
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        self.blackBackgroundView.frame.origin.y = UIScreen.main.hasNotch ? 227 : 195
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        self.blackBackgroundView.frame.origin.y = UIScreen.main.hasNotch ? 262 : 225.5
    }
}

// MARK: - UITextViewDelegate
extension AddActionVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placholder {
            textView.text = nil
            textView.textColor = .white
        } else if textView.text == "" {
            textView.text = placholder
            textView.textColor = .gray200
        }
        
        activityTextView.layer.borderWidth = 1
        activityTextView.layer.borderColor = UIColor.pink100.cgColor
        changeLetterNumLabelColor()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placholder
            textView.textColor = .gray200
        }
        
        activityTextView.layer.borderWidth = 0
        changeLetterNumLabelColor()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let str = activityTextView.text else { return true }
        /// textLength = 기존 텍스트뷰의 텍스트 + 새로 입력할 텍스트 - 지워질 글자 개수
        let textLength = str.count + text.count - range.length
        letterNumLabel.text = "\(textLength)/150"
        return textLength <= 150
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension AddActionVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            photoButton.setImage(image, for: .normal)
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoButton.setImage(image, for: .normal)
        }
        deletePhotoButton.isHidden = false
        dismiss(animated: true, completion: nil)
    }
}
