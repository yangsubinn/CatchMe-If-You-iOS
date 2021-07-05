//
//  characterCVC.swift
//  CatchMe
//
//  Created by 양수빈 on 2021/07/04.
//

import UIKit

class characterCVC: UICollectionViewCell {

    static let identifier = "characterCVC"
    
    // MARK: - IBOutlet
    @IBOutlet weak var characterImage: UIImageView!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        characterImage.backgroundColor = .purple
        characterImage.translatesAutoresizingMaskIntoConstraints = false
        characterImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(174)
        }
    }
}
