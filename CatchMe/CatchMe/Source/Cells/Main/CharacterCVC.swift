//
//  CharacterCVC.swift
//  CatchMe
//
//  Created by 양수빈 on 2021/07/04.
//

import UIKit

class CharacterCVC: UICollectionViewCell {
    static let identifier = "CharacterCVC"
    
    //MARK: - Properties
    let characterImage = UIImageView()
    let reportView = mainReportView()
    
    //MARK: - Dummy Data
    var levels: [String] = ["3", "2", "2", "2", "1"]
    var activitys: [String] = ["10", "5", "6", "8", "1"]
    var totals: [String] = ["90", "70", "10", "6", "100"]
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
        setupLayout()
        setupReportView()
    }
    
    //MARK: - Custom Method
    func configUI() {
        characterImage.image = Character.purple.getCharacterImage(phase: 3, size: 181)
        self.backgroundColor = .clear
    }
    
    func setupLayout() {
        addSubviews([reportView, characterImage])
        
        characterImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIScreen.main.hasNotch ? 44 : 18)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(181)
        }
        
        reportView.snp.makeConstraints { make in
            make.top.equalTo(characterImage.snp.bottom).offset(UIScreen.main.hasNotch ? 54 : 24)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(152)
        }
    }
    
    private func setupReportView() {
        reportView.backgroundColor = .black200
        reportView.layer.cornerRadius = 14
        reportView.layer.borderColor = UIColor.bordergrey.cgColor
        reportView.layer.borderWidth = 2
    }
    
    func changeLabelText() {
//        reportView.levelCountLabel.text = levels[indexPath.row]
//        reportView.activeCountLabel.text = activitys[page]
//        reportView.percentCountLabel.text = totals[page]
    }
    
//    func indexPath (for cell: UICollectionViewCell) -> IndexPath? {
//
//    }
}
