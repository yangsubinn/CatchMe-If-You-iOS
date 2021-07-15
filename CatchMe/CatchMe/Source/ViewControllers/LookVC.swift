//
//  LookVC.swift
//  CatchMe
//
//  Created by 양수빈 on 2021/07/12.
//

import UIKit

import SnapKit

class LookVC: UIViewController {
    //MARK: - Properties
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    let topImageView = UIImageView()
    let topBackImageView  = UIImageView()
    let collectionViewFlowLayout = UICollectionViewFlowLayout()
    
    //MARK: - Lazy Properties
    lazy var backButton = BackButton(self)
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
    
    //MARK: - Server Data
    var nicknames: [String] = []
    var names: [String] = []
    var characters: [Int] = []
    var levels: [Int] = []
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configUI()
        setupCollectionView()
    }
    
    //MARK: - Custom Method
    func setupLayout() {
        view.addSubviews([collectionView, topBackImageView, backButton,
                          titleLabel, subTitleLabel, topImageView])
        
        topBackImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(subTitleLabel.snp.bottom).offset(57)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(UIScreen.main.hasNotch ? 11 : 20)
            make.leading.equalToSuperview().offset(14)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(UIScreen.main.hasNotch ? 28 : 24)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(UIScreen.main.hasNotch ? 28 : 24)
        }
        
        topImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(UIScreen.main.hasNotch ? 84 : 90)
            make.trailing.equalToSuperview().inset(18)
            make.width.equalTo(82)
            make.height.equalTo(64)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(topBackImageView.snp.bottom).offset(-10)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    func configUI() {
        view.backgroundColor = .black100
        
        topBackImageView.image = UIImage(named: "scrollRectangle")
        topImageView.image = UIImage(named: "imgGroupCatchu")
        
        titleLabel.text = "다른 유저들의 캐츄"
        titleLabel.textColor = .white
        titleLabel.font = .stringBoldSystemFont(ofSize: 22)
        
        subTitleLabel.text = "다른 사용자의 캐츄를 둘러보세요!"
        subTitleLabel.textColor = .gray310
        subTitleLabel.font = .stringMediumSystemFont(ofSize: 16)
    }
    
    func setupCollectionView() {
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.setupCollectionViewNib(nib: LookCVC.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
    }
}

// MARK: - UICollectionViewDataSource
extension LookVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 서버 연결시 데이터가 있으면 setupLayout(), 없으면 setupEmptyLayout()
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LookCVC.identifier, for: indexPath) as? LookCVC else {
            return UICollectionViewCell()
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension LookVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let cellWidth = width * (319/375)
        let cellHeight = cellWidth * (112/319)
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 11, left: 28, bottom: 0, right: 28)
    }
}
