//
//  MainCardVC.swift
//  CatchMe
//
//  Created by 양수빈 on 2021/07/06.
//

import UIKit

import Moya
import SnapKit

class MainCardVC: UIViewController {
    //MARK: - Properties
    let nameLabel = UILabel()
    let titleLabel = UILabel()
    let popupButton = UIButton()
    let addButton = UIButton()
    let alignButton = UIButton()
    let topBackView = UIImageView()
    let emptyImageView = UIImageView()
    let emptyTitleLabel = UILabel()
    let emptySubLabel = UILabel()
    let collectionViewFlowLayout = UICollectionViewFlowLayout()
    
    //MARK: - Lazy Properties
    lazy var backButton = BackButton(self)
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
    
    var isFirstButtonChecked = true
    var isSecondButtonChecked = false
    var isThirdButtonChecked = false
    
    //MARK: - Network
    private let authProvider = MoyaProvider<MainCardService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    var cardCharacter: MainCardModel?
    
    //MARK: - Server Data
    var names: [String] = []
    var images: [Int] = []
    var levels: [Int] = []
    var indexs: [Int] = []
    
    override func viewDidAppear(_ animated: Bool) {
        fetchCharacter()
    }

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configUI()
        setupCollectionView()
        setupEmptyLayout()
    }
    
    //MARK: - Custom Method
    func setupLayout() {
        view.addSubviews([collectionView, topBackView, backButton,
                          nameLabel, titleLabel, popupButton,
                          addButton, alignButton])
        
        topBackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(alignButton.snp.bottom).offset(10)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(UIScreen.main.hasNotch ? 11 : 20)
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
            make.top.equalTo(backButton.snp.bottom).offset(16)
            make.trailing.equalToSuperview().inset(27)
            make.width.equalTo(91)
            make.height.equalTo(38)
        }
        
        alignButton.snp.makeConstraints { make in
            make.top.equalTo(addButton.snp.bottom).offset(37)
            make.trailing.equalToSuperview().inset(13)
            make.width.height.equalTo(48)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(topBackView.snp.bottom).offset(-10)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    func configUI() {
        view.backgroundColor = .black100
        
        popupButton.setImage(UIImage(named: "btnGuide"), for: .normal)
        addButton.setImage(UIImage(named: "btnCatchuCatching"), for: .normal)
        alignButton.setImage(UIImage(named: "btnAlign"), for: .normal)
        topBackView.image = UIImage(named: "scrollRectangle")
        emptyImageView.image = UIImage(named: "mainCatchu")
        
//        print("----------------------")
//        print(UserDefaultStorage.userName)
        nameLabel.text = "\(UserDefaultStorage.userName) 님"
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
        
        emptyImageView.isHidden = true
        emptyTitleLabel.isHidden = true
        emptySubLabel.isHidden = true
        
        addButton.addTarget(self, action: #selector(touchupAdd), for: .touchUpInside)
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.setupCollectionViewNib(nib: MainCardCVC.identifier)
        collectionView.backgroundColor = .clear
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionView.showsVerticalScrollIndicator = false
    }
    
    func setupEmptyLayout() {
        view.addSubviews([emptyImageView, emptyTitleLabel, emptySubLabel])
        
        emptyImageView.snp.makeConstraints { make in
            make.top.equalTo(topBackView.snp.bottom).offset(UIScreen.main.hasNotch ? 150 : 102)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(115)
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
            fetchCharacter()
        })

        let createButton = UIAlertAction(title: "최근 생성 순", style: .default, handler: { [unowned self] _ in
            self.isFirstButtonChecked = false
            self.isSecondButtonChecked = true
            self.isThirdButtonChecked = false
            fetchRecentCharacter()
        })
        
        let activeButton = UIAlertAction(title: "활동 많은 순", style: .default, handler: { [unowned self] _ in
            self.isFirstButtonChecked = false
            self.isSecondButtonChecked = false
            self.isThirdButtonChecked = true
            fetchMostCharacter()
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
    
    @objc
    func touchupAdd() {
        let storyboard  = UIStoryboard.init(name: "Character", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "AddCatchuVC") as? AddCatchuVC else { return }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource
extension MainCardVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCardCVC.identifier, for: indexPath) as? MainCardCVC else { return UICollectionViewCell() }
        
        cell.nameLabel.text = names[indexPath.item]
        cell.nameLabel.addCharacterSpacing(kernValue: -0.6, paragraphValue: 4)
        cell.nameLabel.numberOfLines = 2
        cell.setImageView(level: levels[indexPath.item], index: images[indexPath.item])
        cell.setStarLevel(level: levels[indexPath.item])
        cell.characterBackView.backgroundColor = setBackgroundColor(index: indexs[indexPath.item])
        
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

// MARK: - UICollectionViewDelegate
extension MainCardVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Character", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "CharacterVC") as? CharacterVC else { return }
        /// characterIndex 보내주기
//        vc.index = indexs[indexPath.item]
        print("--------------------------------------------------------")
        print(indexs)
        print(indexs[indexPath.item])
        print("--------------------------------------------------------")
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Network
extension MainCardVC {
    func fetchCharacter() {
        var data: [CardCharacter] = []
        authProvider.request(.recentActivity) { [self] response in
            switch response {
            case .success(let result):
                do {
                    self.cardCharacter = try result.map(MainCardModel.self)
                    
                    names.removeAll()
                    levels.removeAll()
                    images.removeAll()
                    indexs.removeAll()
                    
                    data.append(contentsOf: cardCharacter?.data ?? [])

                    if data.isEmpty {
                        emptyImageView.isHidden = false
                        emptyTitleLabel.isHidden = false
                        emptySubLabel.isHidden = false
                        collectionView.isHidden = true
                    } else {
                        emptyImageView.isHidden = true
                        emptyTitleLabel.isHidden = true
                        emptySubLabel.isHidden = true
                        collectionView.isHidden = false
                        
                        
                        for i in 0..<data.count {
                            names.append(data[i].characterName)
                            images.append(data[i].characterImageIndex)
                            levels.append(data[i].characterLevel)
                            indexs.append(data[i].characterIndex)
                        }
                        collectionView.reloadData()
                    }
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func fetchMostCharacter() {
        var data: [CardCharacter] = []
        authProvider.request(.most) { [self] response in
            switch response {
            case .success(let result):
                do {
                    self.cardCharacter = try result.map(MainCardModel.self)
                    
                    names.removeAll()
                    levels.removeAll()
                    images.removeAll()
                    indexs.removeAll()
                    
                    data.append(contentsOf: cardCharacter?.data ?? [])

                    if data.isEmpty {
                        emptyImageView.isHidden = false
                        emptyTitleLabel.isHidden = false
                        emptySubLabel.isHidden = false
                        collectionView.isHidden = true
                    } else {
                        emptyImageView.isHidden = true
                        emptyTitleLabel.isHidden = true
                        emptySubLabel.isHidden = true
                        collectionView.isHidden = false
                        
                        for i in 0..<data.count {
                            names.append(data[i].characterName)
                            images.append(data[i].characterImageIndex)
                            levels.append(data[i].characterLevel)
                            indexs.append(data[i].characterIndex)
                        }
                        collectionView.reloadData()
                    }
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func fetchRecentCharacter() {
        var data: [CardCharacter] = []
        authProvider.request(.recentCreate) { [self] response in
            switch response {
            case .success(let result):
                do {
                    self.cardCharacter = try result.map(MainCardModel.self)
                    
                    names.removeAll()
                    levels.removeAll()
                    images.removeAll()
                    indexs.removeAll()
                    
                    data.append(contentsOf: cardCharacter?.data ?? [])

                    if data.isEmpty {
                        emptyImageView.isHidden = false
                        emptyTitleLabel.isHidden = false
                        emptySubLabel.isHidden = false
                        collectionView.isHidden = true
                    } else {
                        emptyImageView.isHidden = true
                        emptyTitleLabel.isHidden = true
                        emptySubLabel.isHidden = true
                        collectionView.isHidden = false
                        
                        for i in 0..<data.count {
                            names.append(data[i].characterName)
                            images.append(data[i].characterImageIndex)
                            levels.append(data[i].characterLevel)
                            indexs.append(data[i].characterIndex)
                        }
                        collectionView.reloadData()
                    }
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
