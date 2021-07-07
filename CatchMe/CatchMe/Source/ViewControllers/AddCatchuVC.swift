//
//  AddCatchuVC.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/07.
//

import UIKit

class AddCatchuVC: UIViewController {
    // MARK: - lazy Properties
    lazy var xmarkButton = XmarkButton(self)
    
    // MARK: - Properties

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Custom Methods
    private func setupLayout() {
        view.addSubviews([xmarkButton])
    }
}
