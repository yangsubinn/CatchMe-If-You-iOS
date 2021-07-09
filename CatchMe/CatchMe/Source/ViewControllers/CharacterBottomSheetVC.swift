//
//  CharacterBottomSheetVC.swift
//  CatchMe
//
//  Created by Thisisme Hi on 2021/07/09.
//

import UIKit

import Then
import SnapKit

class CharacterBottomSheetVC: UIViewController {
    // MARK: - Properties
    let dimmedView = UIView().then {
        $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupAutoLayout()
    }
    
    // MARK: - Custom Method
    func configUI() {
       
    }
    
    func setupAutoLayout() {
    }
}
