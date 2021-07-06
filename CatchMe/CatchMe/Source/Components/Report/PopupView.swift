//
//  PopupView.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/06.
//

import UIKit

import Then
import SnapKit

class PopupView: UIView {
    // MARK: - lazy Properties
    lazy var xmarkButton = XmarkButton(viewController)
    lazy var characterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionFlowLayout)
    
    // MARK: - Properties
    let dateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 19)
        $0.textColor = .white
    }
    
    let nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .white
        $0.numberOfLines = 2
        $0.lineBreakMode = .byWordWrapping
        $0.textAlignment = .center
    }
    
    let leftButton = UIButton().then {
        $0.backgroundColor = .systemTeal
    }
    
    let rightButton = UIButton().then {
        $0.backgroundColor = .systemBlue
    }
    
    let checkButton = UIButton().then {
        $0.backgroundColor = .systemPink
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        $0.setTitle("확인하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 27
    }

    let collectionFlowLayout = UICollectionViewFlowLayout()
    var viewController = UIViewController()
    var currentIndex: CGFloat = 0
    
    // MARK: - Dummy Data
    var catchus: [String] = ["자유로이 세상을 떠도는 탐험가", "눈만 뜨는 암벽등반하는 날다람쥐", "감바스가 먹고 싶은 아요"]

    // MARK: - Life Cycle
    init(date: String, vc: UIViewController) {
        super.init(frame: .zero)
        viewController = vc
        configUI(date: date)
        setupCollectionView()
        applyButtonHidden()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(24)
        }
        
        xmarkButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(1)
        }
        
        leftButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(141)
            make.leading.equalToSuperview()
        }
        
        rightButton.snp.makeConstraints { make in
            make.top.equalTo(leftButton)
            make.trailing.equalToSuperview()
        }
        
        characterCollectionView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(42)
            make.leading.equalTo(leftButton.snp.trailing)
            make.trailing.equalTo(rightButton.snp.leading)
            make.height.equalTo(150)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(characterCollectionView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(56)
        }
        
        checkButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(40)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(173)
        }
    }
    
    // MARK: - Custom Methods
    private func configUI(date: String) {
        addSubviews([dateLabel, xmarkButton, characterCollectionView,
                    leftButton, rightButton, nameLabel, checkButton])
                    
        backgroundColor = .black
        layer.cornerRadius = 18
        
        nameLabel.text = catchus[0]
        dateLabel.text = date
    }
    
    private func setupCollectionView() {
        collectionFlowLayout.scrollDirection = .horizontal
        
        characterCollectionView.delegate = self
        characterCollectionView.dataSource = self
        characterCollectionView.register(CatchuCVC.self, forCellWithReuseIdentifier: CatchuCVC.identifier)
        
        characterCollectionView.backgroundColor = .clear
        characterCollectionView.isPagingEnabled = true
        characterCollectionView.showsHorizontalScrollIndicator = false
    }
    
    private func applyButtonHidden() {
        let totalCount = catchus.count
        
        if totalCount == 1 {
            leftButton.isHidden = true
            rightButton.isHidden = true
            characterCollectionView.isScrollEnabled = false
        } else {
            switch Int(currentIndex) {
            case 0:
                leftButton.isHidden = true
                rightButton.isHidden = false
            case totalCount-1:
                leftButton.isHidden = false
                rightButton.isHidden = true
            default:
                leftButton.isHidden = false
                rightButton.isHidden = false
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension PopupView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catchus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatchuCVC.identifier, for: indexPath) as? CatchuCVC else {
            return UICollectionViewCell()
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PopupView: UICollectionViewDelegateFlowLayout {
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

extension PopupView: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let cellWidthIncludingSpacing = characterCollectionView.frame.size.width
        let offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        var roundedIndex = round(index)
        
        if scrollView.contentOffset.x > targetContentOffset.pointee.x {
            roundedIndex = floor(index)
        } else if scrollView.contentOffset.x < targetContentOffset.pointee.x {
            roundedIndex = ceil(index)
        } else {
            roundedIndex = round(index)
        }
        
        if currentIndex > roundedIndex {
            currentIndex -= 1
        } else if currentIndex < roundedIndex {
            currentIndex += 1
        }
        
        /// 현재 index로 catchu 이름 설정
        nameLabel.text = catchus[Int(currentIndex)]
        
        /// left, right button hidden 처리
        applyButtonHidden()
    }
}
