//
//  CharacterCVC.swift
//  CatchMe
//
//  Created by 양수빈 on 2021/07/04.
//

import UIKit

class CharacterCVC: UICollectionViewCell {
    static let identifier = "CharacterCVC"
    
    // MARK: - IBOutlet
    @IBOutlet weak var characterImage: UIImageView!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }
    
    func configUI() {
        characterImage.backgroundColor = .purple
        self.backgroundColor = .blue
    }
}