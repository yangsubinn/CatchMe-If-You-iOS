//
//  ViewController.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/06/28.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    lazy var backButton = BackButton(self)
    lazy var xmarkButton = XmarkButton(self)
    var bottomButton = BottomButton(title: "기록하기")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backButton)
        view.addSubview(xmarkButton)
        view.addSubview(bottomButton)
        
        backButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(100)
        }
        
        xmarkButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(100)
        }
        
        bottomButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(150)
            $0.centerX.equalToSuperview()
        }
    }


}

