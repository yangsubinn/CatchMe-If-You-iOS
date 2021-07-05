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

    // MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupCollectionView()
        setupPageControl()
        setupReportView()
    }
    
    // MARK: - Custome Method
    private func configUI() {
        view.backgroundColor = .black
        
        view.addSubviews([dateLabel, settingButton, calendarButton, lookButton, allButton, nameLabel, catchingButton])
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        settingButton.translatesAutoresizingMaskIntoConstraints = false
        calendarButton.translatesAutoresizingMaskIntoConstraints = false
        lookButton.translatesAutoresizingMaskIntoConstraints = false
        allButton.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        catchingButton.translatesAutoresizingMaskIntoConstraints = false
        
        dateLabel.text = "7월 4일 일요일"
        dateLabel.textColor = .white
        dateLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(28)
            make.top.equalToSuperview().offset(64)
        }
        
        settingButton.backgroundColor = .cyan
        calendarButton.backgroundColor = .yellow
        lookButton.backgroundColor = .gray
        allButton.backgroundColor = .purple
        catchingButton.backgroundColor = .lightGray
        
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
        
        nameLabel.text = "솝트없이 못 사는 솝트러버"
        nameLabel.textColor = .white
        nameLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(28)
            make.top.equalTo(view.snp.top).offset(172)
        }
        
        catchingButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(173)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(721)
//            make.top.equalTo(reportView.snp.bottom).offset(-41)
        }
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: characterCVC.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: characterCVC.identifier)
        collectionView.backgroundColor = .clear
    }
    
    private func setupPageControl() {
        pageControl.pages = 5
        
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            pageControl.heightAnchor.constraint(equalToConstant: 12),
            pageControl.widthAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    private func setupReportView() {
        view.addSubview(reportView)
        reportView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(28)
            make.trailing.equalTo(view.snp.trailing).offset(-28)
            make.top.equalTo(nameLabel.snp.bottom).offset(338)
            make.height.equalTo(152)
        }
        reportView.backgroundColor = .darkGray
        reportView.layer.cornerRadius = 14
    }
}

// MARK: - Extension
extension MainVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: characterCVC.identifier, for: indexPath) as? characterCVC else {
            return UICollectionViewCell()
        }
        return cell
    }
}

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

extension MainVC: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // page control selected page 바꾸는 코드
        let page = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.selectedPage = Int(page)
        
        // Label 내용 변경하는 코드
//        changeLabelText(page: Int(page))
    }
}
