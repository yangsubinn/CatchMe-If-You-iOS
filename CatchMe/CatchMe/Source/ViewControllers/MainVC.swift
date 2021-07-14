//
//  MainVC.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/02.
//

import UIKit

import SnapKit
import Moya

class MainVC: UIViewController {
    //MARK: - Properties
    let dateLabel = UILabel()
    let settingButton = UIButton()
    let calendarButton = UIButton()
    let lookButton = UIButton()
    let allButton = UIButton()
    lazy var nameLabel = UILabel()
    let catchingButton = UIButton()
    let pageControl = PageControl()
    let emptyImageView = UIImageView()
    let emptyTitleLabel = UILabel()
    let emptySubTitle = UILabel()
    let catchMeButton = UIButton()
    
    var formatterDate = DateFormatter()
    
    //MARK: - Network
    private let authProvider = MoyaProvider<MainService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    var characterData: MainModel?

    //MARK: - Dummy Data
    var levels: [Int] = []
    var activitys: [Int] = []
    var totals: [Int] = []
    var names: [String] = []
    var characters: [Int] = []
    
    let collectionViewFlowLayout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        let cellWidth = UIScreen.main.bounds.width * (319/375)
        var cellHeight : CGFloat = UIScreen.main.hasNotch ? 450 : 400
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        let spacing = (UIScreen.main.bounds.width - cellWidth) / 2
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        layout.scrollDirection = .horizontal
        return layout
    }()
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())

    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        setupDate()
        fetchCharacter()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTopLayout()
        setupLayout()
//        setupEmptyLayout()
        configUI()
        setupCollectionView()
        setupPageControl()
    }
    
    // MARK: - Custome Method
    private func setupTopLayout() {
        view.addSubviews([dateLabel, settingButton, calendarButton,
                          lookButton, allButton])
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIScreen.main.hasNotch ? 64 : 48)
            make.leading.equalToSuperview().offset(UIScreen.main.hasNotch ? 28 : 24)
        }
        
        settingButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIScreen.main.hasNotch ? 48 : 34)
            make.trailing.equalToSuperview().inset(UIScreen.main.hasNotch ? 13 : 11)
            make.width.height.equalTo(48)
        }
    
        calendarButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIScreen.main.hasNotch ? 48 : 34)
            make.trailing.equalTo(settingButton.snp.leading).offset(5)
            make.width.height.equalTo(48)
        }
        
        lookButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIScreen.main.hasNotch ? 48 : 34)
            make.trailing.equalTo(calendarButton.snp.leading).offset(5)
            make.width.height.equalTo(48)
        }
        
        allButton.snp.makeConstraints { make in
            make.top.equalTo(settingButton.snp.bottom).offset(UIScreen.main.hasNotch ? 20 : 18)
            make.trailing.equalToSuperview().inset(UIScreen.main.hasNotch ? 28 : 24)
            make.width.equalTo(72)
            make.height.equalTo(48)
        }
    }
    
    private func setupLayout() {
        view.addSubviews([nameLabel, catchingButton, collectionView, pageControl])
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIScreen.main.hasNotch ? 172 : 124)
            make.leading.equalToSuperview().offset(UIScreen.main.hasNotch ? 28 : 24)
            make.width.equalTo(220)
            make.height.equalTo(58)
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.top).offset(UIScreen.main.hasNotch ? 50 : 35)
            make.leading.equalToSuperview().offset(UIScreen.main.hasNotch ? 28 : 24)
            make.height.equalTo(UIScreen.main.hasNotch ? 12 : 11)
            make.width.equalTo(UIScreen.main.hasNotch ? 90 : 88)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(UIScreen.main.hasNotch ? 21 : 20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.hasNotch ? 450 : 380)
            make.centerX.equalToSuperview()
        }
        
        catchingButton.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(UIScreen.main.hasNotch ? 28 : 22)
            make.height.equalTo(50)
            make.width.equalTo(173)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupEmptyLayout() {
        view.addSubviews([emptyImageView, emptyTitleLabel, emptySubTitle, catchMeButton])
        
        emptyImageView.snp.makeConstraints { make in
            make.top.equalTo(allButton.snp.bottom).offset(UIScreen.main.hasNotch ? 160 : 100)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(115)
        }
        
        emptyTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyImageView.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
        }
        
        emptySubTitle.snp.makeConstraints { make in
            make.top.equalTo(emptyTitleLabel.snp.bottom).offset(7)
            make.centerX.equalToSuperview()
        }
        
        catchMeButton.snp.makeConstraints { make in
            make.top.equalTo(emptySubTitle.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(173)
            make.height.equalTo(50)
        }
    }
    
    private func configUI() {
        view.backgroundColor = .black100
        
        settingButton.setImage(UIImage(named: "icSetting"), for: .normal)
        calendarButton.setImage(UIImage(named: "icReport"), for: .normal)
        lookButton.setImage(UIImage(named: "icLook"), for: .normal)
        allButton.setImage(UIImage(named: "btnSeeAll"), for: .normal)
        catchingButton.setImage(UIImage(named: "actionActive"), for: .normal)
        catchMeButton.setImage(UIImage(named: "btnCatching"), for: .normal)
        emptyImageView.image = UIImage(named: "catchu")
        
        catchingButton.addTarget(self, action: #selector(setupButtonAction(_:)), for: .touchUpInside)
        
        dateLabel.textColor = .white
        dateLabel.font = .stringMediumSystemFont(ofSize: 15)
        dateLabel.addCharacterSpacing(kernValue: -0.6)

        nameLabel.textColor = .white
        nameLabel.font = .catchuRegularSystemFont(ofSize: 22)
        nameLabel.numberOfLines = 2
        nameLabel.addCharacterSpacing(kernValue: -0.6, paragraphValue: 9)
        
        emptyTitleLabel.text = "캐츄를 추가해보세요!"
        emptyTitleLabel.font = .stringMediumSystemFont(ofSize: 20)
        emptyTitleLabel.textColor = .white
        
        emptySubTitle.text = "캐츄와 함께 다양한 내 모습을 기록해요"
        emptySubTitle.font = .stringMediumSystemFont(ofSize: 14)
        emptySubTitle.textColor = .white
   
    }
    
    private func setupCollectionView() {
        collectionView.collectionViewLayout = collectionViewFlowLayout
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.setupCollectionViewNib(nib: CharacterCVC.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast
        collectionView.isPagingEnabled = false
    }
    
    private func setupPageControl() {
        pageControl.pages = names.count
    }
    
    private func setupDate() {
        formatterDate.locale = Locale(identifier: "ko_KR")
        formatterDate.dateFormat = "M월 d일 EEEE"
        let currentFormatterDate = formatterDate.string(from: Date())
        dateLabel.text = currentFormatterDate
    }
    
    private func setLabels() {
        changeLabelText(index: 0)
    }
    
    private func changeLabelText(index: Int) {
        nameLabel.text = names[index]
    }
    
    // MARK: - @objc
    @objc func setupButtonAction(_ sender: UIButton) {
        guard  let vc = storyboard?.instantiateViewController(identifier: "MainPopupVC") as? MainPopupVC else { return }
        
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource
extension MainVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCVC.identifier, for: indexPath) as? CharacterCVC else { return UICollectionViewCell() }
        
        cell.reportView.setLabel(level: levels[indexPath.item], activity: activitys[indexPath.item], percent: totals[indexPath.item])
        cell.setImageView(level: levels[indexPath.item], index: characters[indexPath.item])
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MainVC: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }

        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing

        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left ) /  cellWidthIncludingSpacing
        var roundedIndex = round(index)
        
        if scrollView.contentOffset.x > targetContentOffset.pointee.x{
            roundedIndex = floor(index)
        } else {
            roundedIndex = ceil(index)
        }
        
        changeLabelText(index: Int(roundedIndex))
        pageControl.selectedPage = Int(roundedIndex)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left,
                         y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}

// MARK: - Network
extension MainVC {
    func fetchCharacter() {
        var data: [MainCharacter] = []
        authProvider.request(.main) { [self] response in
            switch response {
            case .success(let result):
                do {
                    self.characterData = try result.map(MainModel.self)
                    data.append(contentsOf: characterData?.data ?? [])
                    
                    for i in 0..<data.count {
                        names.append(data[i].characterName)
                        levels.append(data[i].characterLevel)
                        activitys.append(data[i].activityCount)
                        totals.append(data[i].countPercentage ?? 0)
                        characters.append(data[i].characterIndex)
                    }
                    
                    collectionView.reloadData()
                    pageControl.pages = names.count
                    
                    if !names.isEmpty {
                        nameLabel.text = names[0]
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
