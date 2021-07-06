//
//  MainCardCVC.swift
//  CatchMe
//
//  Created by 양수빈 on 2021/07/06.
//

import UIKit

class MainCardCVC: UICollectionViewCell {
    static let identifier = "MainCardVC"
    
    // MARK: - Properties
    let characterBackView = UIView()
    let characterImageView = UIImageView()
    let nameLabel = UILabel()
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }
    
    // MARK: - Custom Method
    func configUI() {
        self.backgroundColor = .lightGray
        characterBackView.backgroundColor = .blue
        characterImageView.backgroundColor = .yellow
        
        nameLabel.text = "캐치미캐치유캐치미를정말정말좋아하는캐츄"
    }
    
    func setupLayout() {
        addSubviews([characterImageView, characterBackView, nameLabel])
        
    }
}
