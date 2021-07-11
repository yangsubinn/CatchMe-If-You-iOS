//
//  BackButton.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/02.
//

import UIKit

class BackButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        configUI()
        setupLayout()
    }

    init(_ vc: UIViewController) {
        super.init(frame: .zero)
        configUI()
        setupLayout()
        setupAction(vc: vc)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        setImage(UIImage(named: "btnBack"), for: .normal)
    }
    
    private func setupLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 48),
            self.widthAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func setupAction(vc: UIViewController) {
        let backAction = UIAction { _ in
            vc.navigationController?.popViewController(animated: true)
        }
        self.addAction(backAction, for: .touchUpInside)
    }
}
