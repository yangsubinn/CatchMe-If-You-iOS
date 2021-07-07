//
//  MainCardVC.swift
//  CatchMe
//
//  Created by 양수빈 on 2021/07/06.
//

import UIKit

import SnapKit

class MainCardVC: UIViewController {
    //MARK: - Properties
    lazy var backButton = BackButton(self)
    let nameLabel = UILabel()
    let titleLabel = UILabel()
    let popupButton = UIButton()
    let addButton = UIButton()
    let alignButton = UIButton()
    
    let collectionViewFlowLayout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configUI()
        setupCollectionView()
    }
    
    //MARK: - Custom Method
    func setupLayout() {
        view.addSubviews([backButton, nameLabel, titleLabel,
                          popupButton, addButton, alignButton,
                          collectionView])
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(55)
            make.leading.equalTo(view.snp.leading).offset(14)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(16)
            make.leading.equalTo(view.snp.leading).offset(28)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(6)
            make.leading.equalTo(view.snp.leading).offset(28)
        }
        
        popupButton.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel.snp.trailing)
            make.width.height.equalTo(30)
        }
        
        addButton.snp.makeConstraints { make in
            make.width.equalTo(72)
            make.height.equalTo(48)
            make.trailing.equalTo(view.snp.trailing).inset(27)
            make.top.equalTo(backButton.snp.bottom).offset(14)
        }
        
        alignButton.snp.makeConstraints { make in
            make.width.height.equalTo(48)
            make.trailing.equalTo(view.snp.trailing).inset(13)
            make.top.equalTo(addButton.snp.bottom).offset(27)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(260)
            make.leading.equalTo(view.snp.leading).offset(29)
            make.bottom.equalTo(view.snp.bottom)
            make.trailing.equalTo(view.snp.trailing).inset(28)
        }
    }
    
    func configUI() {
        view.backgroundColor = .black100
        
        nameLabel.text = "최고의대장피엠김해리 님"
        nameLabel.textColor = .white
        nameLabel.font = UIFont.stringBoldSystemFont(ofSize: 14)
        
        titleLabel.text = "캐츄 모아보기"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.stringBoldSystemFont(ofSize: 22)
        
        popupButton.backgroundColor = .blue
        addButton.backgroundColor = .yellow
        alignButton.backgroundColor = .gray300
    }
    
    func setupCollectionView() {
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.setupCollectionViewNib(nib: MainCardCVC.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
    }
}

// MARK: - UICollectionViewDataSource
extension MainCardVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCardCVC.identifier, for: indexPath) as? MainCardCVC else {
            return UICollectionViewCell()
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainCardVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let cellWidth = width * (155/375)
        let cellHeight = cellWidth * (200/155)
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
