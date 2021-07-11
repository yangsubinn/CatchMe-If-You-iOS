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
    let topBackView = UIView()
    let emptyImageView = UIImageView()
    let emptyTitleLabel = UILabel()
    let emptySubLabel = UILabel()
    
    let collectionViewFlowLayout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
    
    var isFirstButtonChecked = true
    var isSecondButtonChecked = false
    var isThirdButtonChecked = false
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configUI()
        setupCollectionView()
//        setupEmptyLayout()
    }
    
    //MARK: - Custom Method
    func setupLayout() {
        view.addSubviews([topBackView, collectionView, backButton,
                          nameLabel, titleLabel, popupButton,
                          addButton, alignButton])
        
        topBackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(alignButton.snp.bottom)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(55)
            make.leading.equalToSuperview().offset(14)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(UIScreen.main.hasNotch ? 28 : 24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(6)
            make.leading.equalToSuperview().offset(UIScreen.main.hasNotch ? 28 : 24)
        }
        
        popupButton.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel.snp.trailing)
            make.width.height.equalTo(30)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(14)
            make.trailing.equalToSuperview().inset(27)
            make.width.equalTo(72)
            make.height.equalTo(48)
        }
        
        alignButton.snp.makeConstraints { make in
            make.top.equalTo(addButton.snp.bottom).offset(27)
            make.trailing.equalToSuperview().inset(13)
            make.width.height.equalTo(48)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(topBackView.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    func configUI() {
        view.backgroundColor = .black100
        popupButton.backgroundColor = .blue
        addButton.backgroundColor = .yellow
        alignButton.backgroundColor = .gray300
        topBackView.backgroundColor = .brown
        emptyImageView.backgroundColor = .pink000
        
        nameLabel.text = "최고의대장피엠김해리 님"
        nameLabel.textColor = .white
        nameLabel.font = .stringBoldSystemFont(ofSize: 14)
        
        titleLabel.text = "캐츄 모아보기"
        titleLabel.textColor = .white
        titleLabel.font = .stringBoldSystemFont(ofSize: 22)
        
        emptyTitleLabel.text = "캐츄를 추가해보세요!"
        emptyTitleLabel.textColor = .gray300
        emptyTitleLabel.font = .stringMediumSystemFont(ofSize: 20)
        
        emptySubLabel.text = "캐츄와 함께 다양한 내 모습을 기록해요"
        emptySubLabel.textColor = .gray300
        emptySubLabel.font = .stringRegularSystemFont(ofSize: 14)
        
        alignButton.addTarget(self, action: #selector(alignButtonAction), for: .touchUpInside)
    }
    
    func setupCollectionView() {
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.setupCollectionViewNib(nib: MainCardCVC.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
    }
    
    func setupEmptyLayout() {
        view.addSubviews([emptyImageView, emptyTitleLabel, emptySubLabel])
        
        emptyImageView.snp.makeConstraints { make in
            make.top.equalTo(topBackView.snp.bottom).offset(UIScreen.main.hasNotch ? 150 : 102)
            make.centerX.equalToSuperview()
            make.width.equalTo(115)
            make.height.equalTo(116)
        }
        
        emptyTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyImageView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        
        emptySubLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyTitleLabel.snp.bottom).offset(7)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func alignButtonAction(sender: UIButton!) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let recordButton = UIAlertAction(title: "최근 기록 순", style: .default, handler: { [unowned self] _ in
            self.isFirstButtonChecked = true
            self.isSecondButtonChecked = false
            self.isThirdButtonChecked = false
            print("recordButton tapped") // 해당 버튼 클릭시 변화 넣어줄 부분
        })

        let createButton = UIAlertAction(title: "최근 생성 순", style: .default, handler: { [unowned self] _ in
            self.isFirstButtonChecked = false
            self.isSecondButtonChecked = true
            self.isThirdButtonChecked = false
            print("createButton tapped")
        })
        
        let activeButton = UIAlertAction(title: "활동 많은 순", style: .default, handler: { [unowned self] _ in
            self.isFirstButtonChecked = false
            self.isSecondButtonChecked = false
            self.isThirdButtonChecked = true
            print("activeButton tapped")
        })
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        recordButton.setValue(isFirstButtonChecked, forKey: "checked")
        createButton.setValue(isSecondButtonChecked, forKey: "checked")
        activeButton.setValue(isThirdButtonChecked, forKey: "checked")

        alert.view.tintColor = .white
        alert.addAction(recordButton)
        alert.addAction(createButton)
        alert.addAction(activeButton)
        alert.addAction(cancel)

        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource
extension MainCardVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 서버 연결시 데이터가 있으면 setupLayout(), 없으면 setupEmptyLayout()
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
        return UIEdgeInsets(top: 11, left: 29, bottom: 0, right: 28)
    }
}
