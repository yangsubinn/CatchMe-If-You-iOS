//
//  CharacterFirstTVC.swift
//  CatchMe
//
//  Created by Thisisme Hi on 2021/07/08.
//

import UIKit

import Kingfisher
import Then
import SnapKit

class CharacterFirstTVC: UITableViewCell {
    static let identifier = "CharacterFirstTVC"
    
    // MARK: - Properties
    var rootVC: UIViewController?
    
    var characterData: CharacterDetail?
    var lookCharacterData: LookCharacterDetail?
    
    var data: ActivityDetail?
    var lookData: LookActivityDetail?
    
    var upperView: CharacterUpperView?
    var headerView: CharacterHeaderView?

    let emptyStateImageView = UIImageView().then {
        $0.image = UIImage(named: "imgCharacterViewEmptyState")
    }
    
    let emptyStateLabel = UILabel().then {
        $0.text = "아직 캐츄의 활동이 없어요"
        $0.font = .stringRegularSystemFont(ofSize: 18)
        $0.textColor = .gray200
        $0.textAlignment = .center
    }
    
    let pinImageView = UIImageView().then {
        $0.image = UIImage(named: "ic")
    }
    
    let lineView = UIView().then {
        $0.backgroundColor = .black200
    }
    
    let dateLabel = UILabel().then {
        $0.text = "2021.08.01"
        $0.textColor = .gray310
        $0.font = .numberRegularSystemFont(ofSize: 14)
        $0.textAlignment = .left
    }
    
    let moreButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "btnMore"), for: .normal)
    }
    
    let contentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 16
        $0.alignment = .center
    }
    
    let commentImageView = UIImageView().then {
        $0.image = UIImage(named: "icCommentRectangle")
    }
    
    let commentLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .stringRegularSystemFont(ofSize: 14)
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.addCharacterSpacing(kernValue: -0.08, paragraphValue: 4)
    }
    
    let photoImageView = UIImageView().then {
        $0.layer.cornerRadius = 18
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.sendSubviewToBack(contentView)
        configUI()
        moreButton.addTarget(self, action: #selector(touchupMoreButton(_:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.isHidden = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Custom Method
    func configUI() {
        backgroundColor = .black100
        self.sendSubviewToBack(contentView)
    }
    
    func setupAutoLayout() {
        addSubviews([lineView, pinImageView, dateLabel,
                     contentStackView, moreButton])
        commentImageView.addSubview(commentLabel)
        contentStackView.addArrangedSubview(commentImageView)
        contentStackView.addArrangedSubview(photoImageView)
        
        pinImageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(36)
            make.leading.equalTo(self.snp.leading).inset(22)
            make.width.height.equalTo(12)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(pinImageView.snp.bottom).inset(1)
            make.leading.equalTo(self.snp.leading).inset(28)
            make.bottom.equalToSuperview()
            make.width.equalTo(1)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(pinImageView.snp.trailing).offset(9)
            make.bottom.equalTo(pinImageView.snp.bottom).offset(2)
        }
        
        moreButton.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(20)
            make.trailing.equalTo(self.snp.trailing).inset(6)
            make.width.height.equalTo(48)
        }
        
        contentStackView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(12)
            make.leading.equalTo(lineView.snp.trailing).offset(16)
            make.bottom.equalTo(self.snp.bottom).inset(5)
            make.trailing.equalTo(self.snp.trailing).inset(28)
        }
        
        commentImageView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(commentImageView.snp.top).inset(12)
            make.leading.equalTo(commentImageView.snp.leading).inset(14)
            make.trailing.equalTo(commentImageView.snp.trailing).inset(14)
            make.bottom.equalTo(commentImageView.snp.bottom).inset(12)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
    }
    
    func setupEmptyLayout() {
        addSubviews([emptyStateImageView, emptyStateLabel])
        
        emptyStateImageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(25)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.hasNotch ? 251 : 0)
            make.height.equalTo(UIScreen.main.hasNotch ? 145 : 0)
        }
        
        emptyStateLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyStateImageView.snp.bottom).offset(UIScreen.main.hasNotch ? 0 : 10)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func touchupMoreButton(_ sender: UIButton) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        let alertViewController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertViewController.view.tintColor = .white
        
        if let actionSheet = alertViewController.view.subviews.first,
           let secondSheet = alertViewController.view.subviews.last {
            for innerView in actionSheet.subviews {
                innerView.backgroundColor = .black300
                innerView.layer.cornerRadius = 18.0
                innerView.clipsToBounds = true
            }
            for innerView in secondSheet.subviews {
                innerView.backgroundColor = .black300
                innerView.layer.cornerRadius = 18.0
                innerView.clipsToBounds = true
            }
        }
        
        let editAction = UIAlertAction(title: "수정", style: .default) { result in
            guard let data = self.data,
                  let selectedData = self.characterData
            else { return }
            let vc = AddActionVC()
            vc.isEdited = true
            vc.text = data.activityContent
            vc.photoURL = self.photoImageView.image
            vc.date = "\(data.activityYear).\(data.activityMonth).\(data.activityDay)"
            vc.catchu = self.upperView?.characterImageView.setCharacterImage(
                level: selectedData.characterLevel,
                index: selectedData.characterImageIndex,
                size: 151
            )
            vc.activityIndex = data.activityIndex
            vc.characterIndex = selectedData.characterIndex
            vc.name = self.characterData?.characterName
            vc.modalPresentationStyle = .overFullScreen
            self.rootVC?.present(vc, animated: true, completion: nil)
        }
        
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { result in
            let vc = CharacterPopupVC()
            guard let data = self.data,
                  let selectedData = self.characterData
            else { return }
            vc.activityIndex = data.activityIndex
            vc.characterIndex = selectedData.characterIndex
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            self.rootVC?.present(vc, animated: true, completion: nil)
        }
        
        deleteAction.setValue(UIColor.red100, forKey: "titleTextColor")
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alertViewController.addAction(editAction)
        alertViewController.addAction(deleteAction)
        alertViewController.addAction(cancelAction)
        
        self.rootVC?.present(alertViewController, animated: true, completion: nil)
    }
    
    func setData() {
        guard let data = data else { return }
        dateLabel.text = data.activityYear + "." + data.activityMonth + "." + data.activityDay
        commentLabel.text = data.activityContent

        if let image = URL(string: data.activityImage ?? "") {
            if data.activityImage == "" {
                photoImageView.isHidden = true
            } else {
                photoImageView.kf.setImage(with: image)
                photoImageView.snp.makeConstraints { make in
                    make.height.equalTo(228)
                }
            }
        }
    }
    
    func setLookData() {
        
        guard let data = lookData else { return }
        dateLabel.text = data.activityYear + "." + data.activityMonth + "." + data.activityDay
        commentLabel.text = data.activityContent

        if let image = URL(string: data.activityImage ?? "") {
            if data.activityImage == "" {
                photoImageView.isHidden = true
            } else {
                photoImageView.kf.setImage(with: image)
                photoImageView.snp.makeConstraints { make in
                    make.height.equalTo(228)
                }
            }
        }
    }
}
