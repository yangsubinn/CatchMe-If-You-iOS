//
//  MainVC.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/02.
//

import UIKit

import SnapKit

class MainVC: UIViewController {
    //MARK: - Properties
    let dateLabel = UILabel()
    let settingButton = UIButton()
    let calendarButton = UIButton()
    let lookButton = UIButton()
    let allButton = UIButton()
    let nameLabel = UILabel()
    let catchingButton = UIButton()
    let pageControl = PageControl()
    let reportView = mainReportView()
    let emptyImageView = UIImageView()
    let emptyTitleLabel = UILabel()
    let emptySubTitle = UILabel()
    let catchMeButton = UIButton()
    
    var formatterDate = DateFormatter()
    
    //MARK: - Dummy Data
    var levels: [String] = ["3", "2", "2", "2", "1"]
    var activitys: [String] = ["10", "5", "6", "8", "1"]
    var totals: [String] = ["90", "70", "10", "6", "100"]
    
    let collectionViewFlowLayout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDate()
        setupReportView()
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
            make.trailing.equalTo(settingButton.snp.leading)
            make.width.height.equalTo(48)
        }
        
        lookButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIScreen.main.hasNotch ? 48 : 34)
            make.trailing.equalTo(calendarButton.snp.leading)
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
        view.addSubviews([nameLabel, reportView, catchingButton,
                          collectionView, pageControl])
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIScreen.main.hasNotch ? 172 : 124)
            make.leading.equalToSuperview().offset(UIScreen.main.hasNotch ? 28 : 24)
            make.width.equalTo(195)
            make.height.equalTo(62)
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
            make.height.equalTo(UIScreen.main.hasNotch ? 269 : 210)
            make.centerX.equalToSuperview()
        }
        
        reportView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(UIScreen.main.hasNotch ? 30 : 14)
            make.leading.trailing.equalToSuperview().inset(UIScreen.main.hasNotch ? 28 : 24)
            make.height.equalTo(152)
        }
        
        catchingButton.snp.makeConstraints { make in
            make.top.equalTo(reportView.snp.bottom).offset(UIScreen.main.hasNotch ? 30 : 22)
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
        
        dateLabel.textColor = .white
        dateLabel.font = .stringMediumSystemFont(ofSize: 15)
        dateLabel.addCharacterSpacing(kernValue: -0.6)
        
        nameLabel.text = "솝트없이못사는솝트러버솝트러버솝트"
        nameLabel.textColor = .white
        nameLabel.font = .catchuRegularSystemFont(ofSize: 22)
        nameLabel.numberOfLines = 2
        
        let attributedString = NSMutableAttributedString(string: nameLabel.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        nameLabel.attributedText = attributedString
        
        emptyTitleLabel.text = "캐츄를 추가해보세요!"
        emptyTitleLabel.font = .stringMediumSystemFont(ofSize: 20)
        emptyTitleLabel.textColor = .white
        
        emptySubTitle.text = "캐츄와 함께 다양한 내 모습을 기록해요"
        emptySubTitle.font = .stringMediumSystemFont(ofSize: 14)
        emptySubTitle.textColor = .white
    }
    
    private func setupCollectionView() {
        collectionViewFlowLayout.scrollDirection = .horizontal
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.setupCollectionViewNib(nib: CharacterCVC.identifier)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    private func setupPageControl() {
        pageControl.pages = 5
    }
    
    private func setupReportView() {
        reportView.backgroundColor = .black200
        reportView.layer.cornerRadius = 14
        reportView.layer.borderColor = UIColor.bordergrey.cgColor
        reportView.layer.borderWidth = 2
    }
    
    private func setupDate() {
        formatterDate.locale = Locale(identifier: "ko_KR")
        formatterDate.dateFormat = "M월 d일 EEEE"
        let currentFormatterDate = formatterDate.string(from: Date())
        dateLabel.text = currentFormatterDate
    }
    
    private func setLabels() {
        changeLabelText(page: 0)
    }
    
    private func changeLabelText(page: Int) {
        reportView.levelCountLabel.text = levels[page]
        reportView.activeCountLabel.text = activitys[page]
        reportView.percentCountLabel.text = totals[page]
    }
}

// MARK: - UICollectionViewDataSource
extension MainVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCVC.identifier, for: indexPath) as? CharacterCVC else {
            return UICollectionViewCell()
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - UICollectionViewDelegate
extension MainVC: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        /// page control selected page 바꾸는 코드
        let page = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.selectedPage = Int(page)
        
        /// Label 내용 변경하는 코드
        changeLabelText(page: Int(page))
    }
}
