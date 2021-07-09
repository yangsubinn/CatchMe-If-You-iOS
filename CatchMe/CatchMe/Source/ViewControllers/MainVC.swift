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
    
    var formatterDate = DateFormatter()
    
    let collectionViewFlowLayout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDate()
        setupReportView()
        setupLayout()
        configUI()
        setupCollectionView()
        setupPageControl()
    }
    
    // MARK: - Custome Method
    private func setupLayout() {
        view.addSubviews([dateLabel, settingButton, calendarButton,
                          lookButton, allButton, nameLabel,
                          reportView, catchingButton, collectionView,
                          pageControl])
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIScreen.main.hasNotch ? 64 : 58)
            make.leading.equalToSuperview().offset(UIScreen.main.hasNotch ? 28 : 24)
        }
        
        settingButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(UIScreen.main.hasNotch ? 13 : 11)
            make.top.equalToSuperview().offset(UIScreen.main.hasNotch ? 48 : 44)
            make.width.height.equalTo(48)
        }
    
        calendarButton.snp.makeConstraints { make in
            make.trailing.equalTo(settingButton.snp.leading)
            make.top.equalToSuperview().offset(UIScreen.main.hasNotch ? 48 : 44)
            make.width.height.equalTo(48)
        }
        
        lookButton.snp.makeConstraints { make in
            make.trailing.equalTo(calendarButton.snp.leading)
            make.top.equalToSuperview().offset(UIScreen.main.hasNotch ? 48 : 44)
            make.width.height.equalTo(48)
        }
        
        allButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(UIScreen.main.hasNotch ? 28 : 24)
            make.top.equalTo(settingButton.snp.bottom).offset(UIScreen.main.hasNotch ? 20 : 18)
            make.width.equalTo(72)
            make.height.equalTo(30)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(UIScreen.main.hasNotch ? 28 : 24)
            make.top.equalToSuperview().offset(UIScreen.main.hasNotch ? 172 : 132)
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.top).offset(UIScreen.main.hasNotch ? 50 : 35)
            make.leading.equalToSuperview().offset(UIScreen.main.hasNotch ? 28 : 24)
            make.height.equalTo(UIScreen.main.hasNotch ? 12 : 11)
            make.width.equalTo(UIScreen.main.hasNotch ? 90 : 88)
        }
        
        reportView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(UIScreen.main.hasNotch ? 28 : 24)
            make.trailing.equalToSuperview().inset(UIScreen.main.hasNotch ? 28 : 24)
            make.top.equalTo(collectionView.snp.bottom).offset(UIScreen.main.hasNotch ? 30 : 26)
            make.height.equalTo(152)
        }
        
        catchingButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(173)
            make.centerX.equalToSuperview()
            make.top.equalTo(reportView.snp.bottom).offset(UIScreen.main.hasNotch ? 41 : 28)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(21)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.hasNotch ? 269 : 210)
        }
    }
    
    private func configUI() {
        view.backgroundColor = .black
        
        dateLabel.textColor = .white
        dateLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        
        nameLabel.text = "솝트없이 못 사는 솝트러버"
        nameLabel.textColor = .white
        nameLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        settingButton.backgroundColor = .cyan
        calendarButton.backgroundColor = .yellow
        lookButton.backgroundColor = .gray
        allButton.backgroundColor = .purple
        catchingButton.backgroundColor = .lightGray
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
//        pageControl.backgroundColor = .white
    }
    
    private func setupReportView() {
        reportView.backgroundColor = .darkGray
        reportView.layer.cornerRadius = 14
    }
    
    private func setupDate() {
        formatterDate.locale = Locale(identifier: "ko_KR")
        formatterDate.dateFormat = "M월 d일 EEEE"
        let currentFormatterDate = formatterDate.string(from: Date())
        dateLabel.text = currentFormatterDate
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
        // page control selected page 바꾸는 코드
        let page = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.selectedPage = Int(page)
        
        // Label 내용 변경하는 코드
//        changeLabelText(page: Int(page))
    }
}
