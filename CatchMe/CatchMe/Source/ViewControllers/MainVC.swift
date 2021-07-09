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
                          reportView, catchingButton, collectionView])
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(UIScreen.main.hasNotch ? 28 : 20)
            make.top.equalToSuperview().offset(UIScreen.main.hasNotch ? 64 : 55)
//            make.leading.equalTo(view.snp.leading).offset(28)
//            make.top.equalToSuperview().offset(64)
        }
        
        settingButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.snp.trailing).offset(-13)
            make.top.equalTo(view.snp.top).offset(48)
            make.width.height.equalTo(48)
        }
    
        calendarButton.snp.makeConstraints { make in
            make.width.height.equalTo(48)
            make.trailing.equalTo(settingButton.snp.leading)
            make.top.equalTo(view.snp.top).offset(48)
        }
        
        lookButton.snp.makeConstraints { make in
            make.trailing.equalTo(calendarButton.snp.leading)
            make.top.equalTo(view.snp.top).offset(48)
            make.width.height.equalTo(48)
        }
        
        allButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.snp.trailing).offset(-28)
            make.top.equalTo(settingButton.snp.bottom).offset(20)
            make.width.equalTo(72)
            make.height.equalTo(30)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(28)
            make.top.equalTo(view.snp.top).offset(172)
        }
        
        reportView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(28)
            make.trailing.equalTo(view.snp.trailing).inset(28)
            make.top.equalTo(nameLabel.snp.bottom).offset(338)
            make.height.equalTo(152)
        }
        
        catchingButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(173)
            make.centerX.equalToSuperview()
            make.top.equalTo(reportView.snp.bottom).offset(41)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(21)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(269)
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
        
        view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(100)
            make.leading.equalTo(view.snp.leading).offset(28)
            make.height.equalTo(12)
            make.width.equalTo(90)
        }
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
