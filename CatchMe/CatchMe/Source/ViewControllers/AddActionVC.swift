//
//  AddActionVC.swift
//  CatchMe
//
//  Created by Thisisme Hi on 2021/07/07.
//

import UIKit

import Alamofire
import Kingfisher
import Moya
import Then
import SnapKit

class AddActionVC: UIViewController {
    // MARK: - Properties
    var keyHeight = CGFloat()
    let placeholder: String = "(예 : 오늘 아침에 일어나서 중랑천 2km 뛰었음)"
    var text: String?
    var photoURL: UIImage?
    var date: String?
    var name: String?
    var catchu: UIImage?
    var buttonImage: UIImage?
    var report: CharacterReportData?
    var isEdited: Bool = false
    var reloadData: (() -> ())?
    var characterIndex = 0
    var activityIndex = 0
    
    let imagePicker = UIImagePickerController()
    let nameView = UIView()
    
    let pinkBackgroundView = UIView().then {
        $0.backgroundColor = .pink100
    }
    
    let dateButton = UIButton().then {
        $0.setImage(UIImage(named: "btnDropdown"), for: .normal)
        $0.addTarget(self, action: #selector(touchupDateButton(_:)), for: .touchUpInside)
    }
    
    let closeButton = UIButton().then {
        $0.setImage(UIImage(named: "btnClose"), for: .normal)
        $0.addTarget(self, action: #selector(touchupCloseButton(_:)), for: .touchUpInside)
    }
    
    let nameLabel = UILabel().then {
        $0.font = .catchuRegularSystemFont(ofSize: 21)
        $0.textAlignment = .left
        $0.textColor = .white
        $0.numberOfLines = 2
        $0.lineBreakMode = .byWordWrapping
        $0.addCharacterSpacing(kernValue: -0.6, paragraphValue: 4)
    }
    
    let dateLabel = UILabel().then {
        $0.font = .numberRegularSystemFont(ofSize: 17)
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    let catchuImageView = UIImageView().then {
        $0.image = Character.orange.getCharacterImage(phase: 2, size: 151)
        $0.contentMode = .scaleAspectFill
    }
    
    let radiusImageView = UIImageView().then {
        $0.image = UIImage(named: "imgScrollRadius")
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
        $0.font = .stringRegularSystemFont(ofSize: 14)
        $0.backgroundColor = .black200
        $0.textColor = .white
        $0.layer.cornerRadius = 13
        $0.textAlignment = .left
        $0.tintColor = .pink100
        $0.textContainerInset = UIEdgeInsets(top: UIScreen.main.hasNotch ? 18 : 11, left: UIScreen.main.hasNotch ? 18 : 14, bottom: UIScreen.main.hasNotch ? 13 : 6, right: UIScreen.main.hasNotch ? 18 : 8)
        
        let attributedString = NSMutableAttributedString(string: $0.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
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
        $0.setImage(UIImage(named: "btnAddPhoto"), for: .normal)
        $0.layer.cornerRadius = 13
        $0.clipsToBounds = true
        $0.imageView?.contentMode = .scaleAspectFill
        $0.addTarget(self, action: #selector(touchupPhotoButton(_:)), for: .touchUpInside)
    }
    
    let deletePhotoButton = UIButton().then {
        $0.setImage(UIImage(named: "btnRemove"), for: .normal)
        $0.addTarget(self, action: #selector(touchupDeletePhotoButton(_:)), for: .touchUpInside)
    }
    
    let uploadButton = BottomButton(title: "캐칭 완료").then {
        $0.backgroundColor = .gray300
        $0.addTarget(self, action: #selector(touchupUploadButton), for: .touchUpInside)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupAutoLayout()
        setupTextView()
        setupImagePicker()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    // MARK: - Custom Method
    func configUI() {
        view.backgroundColor = .black100

        deletePhotoButton.isHidden = true
        
        print("characterIndex :\(characterIndex)")
        print("activityIndex :\(activityIndex)")
        
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let dateString = dateFormatter.string(from: now)
        dateLabel.text = dateString
        nameLabel.text = name
        catchuImageView.image = catchu
        uploadButton.backgroundColor = .pink100
        
        if photoURL == nil {
            photoButton.setImage(UIImage(named: "btnAddPhoto"), for: .normal)
        } else {
            photoButton.setImage(photoURL, for: .normal)
            deletePhotoButton.isHidden = false
        }
    }
    
    func setupAutoLayout() {
        view.addSubviews([blackBackgroundView, pinkBackgroundView, radiusImageView,
                          catchuImageView, dateLabel, dateButton,
                          closeButton, nameView, nameLabel])
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
        
        nameView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(UIScreen.main.hasNotch ? 17 : 13)
            make.leading.equalToSuperview().inset(UIScreen.main.hasNotch ? 28 : 20)
            make.width.equalTo(186)
            make.height.lessThanOrEqualTo(58)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nameView.snp.centerY)
            make.leading.equalTo(nameView.snp.leading)
            make.width.equalTo(186)
            make.height.lessThanOrEqualTo(58)
        }
        
        radiusImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(pinkBackgroundView.snp.bottom)
            make.height.equalTo(UIScreen.main.hasNotch ? 36 : 25)
        }
        
        catchuImageView.snp.makeConstraints { make in
            make.bottom.equalTo(radiusImageView.snp.top).offset(35)
            make.trailing.equalToSuperview().inset(UIScreen.main.hasNotch ? 15 : 15)
            make.width.height.equalTo(151)
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
        activityTextView.text = placeholder /// 초반 placeholder 생성
        activityTextView.textColor = .gray200 /// 초반 placeholder 색상 설정
        activityTextView.font = .stringRegularSystemFont(ofSize: 14)
    }
    
    func setupImagePicker() {
        imagePicker.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.2, animations: {
            self.blackBackgroundView.transform = .identity
        })
    }

    func setLabel(text: String) {
        print("텍스트:\(text)")
        dateLabel.text = text
    }
    
    func setupNotification() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTable"), object: nil)
    }
    
    // MARK: - @objc
    @objc func touchupCloseButton(_ sender: UIButton) {
        let vc = AddActionPopupVC()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func touchupDateButton(_ sender: UIButton) {
        let vc = AddActionDatePickerPopupVC()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.sendData = { text in
            self.dateLabel.text = text
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func touchupPhotoButton(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func touchupDeletePhotoButton(_ sender: UIButton) {
        photoButton.setImage(UIImage(named: "btnAddPhoto"), for: .normal)
        if photoButton.currentImage == UIImage(named: "btnAddPhoto") {
            deletePhotoButton.isHidden = true
        } else {
            deletePhotoButton.isHidden = false
        }
    }
    
    @objc func touchupUploadButton(_ sender: UIButton) {
        guard let date = self.dateLabel.text?.split(separator: ".") else { print("날짜형식반영완료"); return }
        if isEdited {
            print("수정")
            AddActionEditService.shared.editActivity(imageData: buttonImage,
                                                     content: activityTextView.text!,
                                                     year: String(date[0]),
                                                     month: String(date[1]),
                                                     day: String(date[2]),
                                                     index: characterIndex,
                                                     activityIndex: activityIndex) { result in
                switch result {
                case .success(let msg):
                    print("success", msg)
                    self.dismiss(animated: true, completion: {
                        self.setupNotification()
                    })
                case .requestErr(let msg):
                    print("requestERR", msg)
                case .pathErr:
                    print("pathERR")
                case .serverErr:
                    print("serverERR")
                case .networkFail:
                    print("networkFail")
                }
            }
        } else if isEdited == false {
            print("글 생성")
            if activityTextView.text == placeholder || activityTextView.text == "" {
                uploadButton.isEnabled = true
            } else {
                uploadButton.isEnabled = false
            }
            AddActionNewService.shared.uploadNewActivity(imageData: buttonImage,
                                                         content: activityTextView.text!,
                                                         year: String(date[0]),
                                                         month: String(date[1]),
                                                         day: String(date[2]),
                                                         index: characterIndex) { result in
                switch result {
                case .success(let msg):
                    print("success", msg)
                    self.reloadData?()
                    self.dismiss(animated: true, completion: nil)
                case .requestErr(let msg):
                    print("requestERR", msg)
                case .pathErr:
                    print("pathERR")
                case .serverErr:
                    print("serverERR")
                case .networkFail:
                    print("networkFail")
                }
            }
        }
    }
}

// MARK: - UITextViewDelegate
extension AddActionVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        activityTextView.layer.borderWidth = 1
        activityTextView.layer.borderColor = UIColor.pink100.cgColor
        
        if textView.text == placeholder { /// 플레이스 홀더
            textView.text = nil
            textView.textColor = .white
        } else if textView.text.trimmingCharacters(in: .whitespaces).isEmpty {
            textView.text = placeholder
            textView.textColor = .gray200
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.blackBackgroundView.transform = CGAffineTransform(translationX: 0, y: -30)
        })
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if activityTextView.text.count > 150 {
            activityTextView.deleteBackward()
        }
        
        /// 아래 글자 수 표시되게 하기
        let textCount = activityTextView.text.count
        letterNumLabel.text = "\(textCount)/150"
        let attributedString = NSMutableAttributedString(string: "\(textCount)/150")
        attributedString.addAttribute(.foregroundColor, value: UIColor.pink100, range: ("\(textCount)/150" as NSString).range(of:"\(textCount)"))
        letterNumLabel.attributedText = attributedString
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        activityTextView.layer.borderWidth = 0

        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { /// 플레이스 홀더
            textView.text = placeholder
            textView.textColor = .gray200
            letterNumLabel.textColor = .gray200
        }
    
        UIView.animate(withDuration: 0.2, animations: {
            self.blackBackgroundView.transform = .identity
        })
        
        if activityTextView.text == placeholder || activityTextView.text.trimmingCharacters(in: .whitespaces).isEmpty {
            uploadButton.backgroundColor = .gray300
            letterNumLabel.text = "0/150"
        } else {
            uploadButton.backgroundColor = .pink100
        }
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension AddActionVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            photoButton.setImage(image, for: .normal)
            buttonImage = image
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoButton.setImage(image, for: .normal)
            buttonImage = image
        }
        deletePhotoButton.isHidden = false
        dismiss(animated: true, completion: nil)
    }
}
