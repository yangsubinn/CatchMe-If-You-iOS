//
//  LookVC.swift
//  CatchMe
//
//  Created by 양수빈 on 2021/07/12.
//

import UIKit

import Moya
import SnapKit

class LookVC: UIViewController {
    //MARK: - Properties
    let titleLabel = UILabel()
    let topImageView = UIImageView()
    let topBackImageView  = UIImageView()
    let collectionViewFlowLayout = UICollectionViewFlowLayout()
    
    //MARK: - Lazy Properties
    lazy var backButton = BackButton(self)
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
    
    //MARK: - Network
    private let authProvider = MoyaProvider<LookService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    var otherCharacter: LookModel?
    
    //MARK: - Server Data
    var nicknames: [String] = []
    var names: [String] = []
    var images: [Int] = []
    var levels: [Int] = []
    var userids: [String] = []
    var indexs: [Int] = []
    var colors: [UIColor] = [.back300, .back300, .back200, .back400, .back100, .back400, .back200, .back100]
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configUI()
        setupCollectionView()
        fetchOtherCharacter()
    }
    
    //MARK: - Custom Method
    func setupLayout() {
        view.addSubviews([collectionView, topBackImageView, backButton,
                          titleLabel, topImageView])
        
        topBackImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(titleLabel.snp.bottom).offset(60)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(UIScreen.main.hasNotch ? 11 : 20)
            make.leading.equalToSuperview().offset(14)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(UIScreen.main.hasNotch ? 28 : 24)
            make.height.equalTo(30)
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
        
        titleLabel.text = "다른 캐츄 구경하기"
        titleLabel.textColor = .white
        titleLabel.font = .stringBoldSystemFont(ofSize: 22)
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
        return names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LookCVC.identifier, for: indexPath) as? LookCVC else {
            return UICollectionViewCell()
        }
        
        cell.nicknameLabel.text = "\(nicknames[indexPath.item]) 님의"
        cell.characterLabel.text = names[indexPath.item]
        cell.setImageView(level: levels[indexPath.item], index: images[indexPath.item])
        cell.characterBackgroundView.backgroundColor = colors[images[indexPath.item]-1]
        
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

// MARK: - UICollectionViewDelegate
extension LookVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Character", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "CharacterVC") as? CharacterVC else { return }

        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - Network
extension LookVC {
    func fetchOtherCharacter() {
        var data: [OtherCharacter] = []
        authProvider.request(.other) { [self] response in
            switch response {
            case .success(let result):
                do {
                    self.otherCharacter = try result.map(LookModel.self)
                    
                    nicknames.removeAll()
                    names.removeAll()
                    images.removeAll()
                    levels.removeAll()
                    userids.removeAll()
                    indexs.removeAll()
                    
                    data.append(contentsOf: otherCharacter?.data ?? [])
                    
                    for i in 0..<data.count {
                        nicknames.append(data[i].userNickname)
                        names.append(data[i].characterName)
                        images.append(data[i].characterImageIndex)
                        levels.append(data[i].characterLevel)
                        userids.append(data[i].userID)
                        indexs.append(data[i].characterIndex)
                    }
                    collectionView.reloadData()
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
