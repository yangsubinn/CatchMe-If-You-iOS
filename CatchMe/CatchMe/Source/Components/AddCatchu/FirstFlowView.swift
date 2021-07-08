//
//  FirstFlowView.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/07.
//

import UIKit

import SnapKit

class FirstFlowView: UIView {
    // MARK: - Lazy Properties
    lazy var catchuCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
    lazy var cellCount = colors.count
    
    // MARK: - Properties
    let titleView = CatchuTitleView(title: "새로운 캐츄를 잡아볼까요?", subTitle: "내 모습을 가장 잘 보여주는 캐츄를 골라주세요")
    let collectionViewFlowLayout = UICollectionViewFlowLayout()
    let cellSize = CGSize(width: 150, height: 150)
    
    var minItemSpacing: CGFloat = 25
    var previousIndex = 0
    
    // MARK: - Dummy Data
    /// 후에 enum으로 사용하면 편리할 듯 -> 아니면 public하게 전체적으로 사용할 수 있도록 만들기
    let colors: [UIColor] = [.systemRed, .systemBlue, .systemPink, .systemTeal, .systemGray, .systemGreen, .systemOrange, .systemYellow, .systemPurple, .systemIndigo]

    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Methods
    private func setupLayout() {
        addSubviews([titleView, catchuCollectionView])
        
        titleView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(28)
        }
        
        catchuCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(UIScreen.main.hasNotch ? 160 : 100)
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(250)
        }
    }
    
    private func setupCollectionView() {
        collectionViewFlowLayout.scrollDirection = .horizontal
        
        catchuCollectionView.dataSource = self
        catchuCollectionView.delegate = self
        catchuCollectionView.register(CarouselCVC.self, forCellWithReuseIdentifier: CarouselCVC.identifier)
        
        catchuCollectionView.backgroundColor = .clear
        catchuCollectionView.contentInsetAdjustmentBehavior = .never
        catchuCollectionView.decelerationRate = .fast
        catchuCollectionView.contentInsetAdjustmentBehavior = .never
        catchuCollectionView.showsHorizontalScrollIndicator = false
        
        let cellWidth: CGFloat = floor(cellSize.width)
        let insetX = (UIScreen.main.bounds.size.width - cellWidth) / 2.0
        catchuCollectionView.contentInset = UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.01, execute: {
            let indexPath = IndexPath(item: 0, section: 0)
            if let cell = self.catchuCollectionView.cellForItem(at: indexPath) {
                self.animateZoomforCell(zoomCell: cell)
            }
        })
    }
}

// MARK: - UICollectionViewDataSource
extension FirstFlowView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCVC.identifier, for: indexPath) as? CarouselCVC else {
            return UICollectionViewCell()
        }
        cell.setupCharacter(color: colors[indexPath.item])
        animateZoomforCellremove(zoomCell: cell)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FirstFlowView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minItemSpacing
    }
}

// MARK: - UICollectionViewDelegate
extension FirstFlowView: UICollectionViewDelegate {
    /// paging effect
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let cellWidthIncludeSpacing = cellSize.width + minItemSpacing
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludeSpacing
        let roundedIndex: CGFloat = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludeSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
    
    /// Carousel Effect
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let cellWidthIncludeSpacing = cellSize.width + minItemSpacing
        let offsetX = catchuCollectionView.contentOffset.x
        let index = (offsetX + catchuCollectionView.contentInset.left) / cellWidthIncludeSpacing
        let roundedIndex = round(index)
        let indexPath = IndexPath(item: Int(roundedIndex), section: 0)
        if let cell = catchuCollectionView.cellForItem(at: indexPath) {
            animateZoomforCell(zoomCell: cell)
        }
        
        if Int(roundedIndex) != previousIndex {
            let preIndexPath = IndexPath(item: previousIndex, section: 0)
            if let preCell = catchuCollectionView.cellForItem(at: preIndexPath) {
                animateZoomforCellremove(zoomCell: preCell)
            }
            previousIndex = indexPath.item
        }
    }
    
    private func animateZoomforCell(zoomCell: UICollectionViewCell) {
       let animation = CATransform3DTranslate(CATransform3DIdentity, 0, -35, 0.5)
       UIView.animate(withDuration: 0.2,
                      delay: 0,
                      options: .curveEaseOut,
                      animations: {
                        zoomCell.transform3D = animation
                      }, completion: nil)
    }
   
    private func animateZoomforCellremove(zoomCell: UICollectionViewCell) {
       UIView.animate(withDuration: 0.2,
                      delay: 0,
                      options: .curveEaseOut,
                      animations: {
                        zoomCell.transform3D = CATransform3DScale(CATransform3DIdentity, 0.5, 0.5, 1)
                      }, completion: nil)
    }
}
