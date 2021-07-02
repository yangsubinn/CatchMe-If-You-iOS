//
//  XmarkButton.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/02.
//

import UIKit

class XmarkButton: UIButton {
    
    init(_ vc: UIViewController) {
        super.init(frame: .zero)
        configUI()
        setupLayout()
        setupAction(vc: vc)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Asset들어오면 Asset으로 변경할 예정
    private func configUI() {
        backgroundColor = .systemRed
    }
    
    private func setupLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 48),
            self.widthAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func setupAction(vc: UIViewController) {
        let xmarkAction = UIAction { _ in
            print("print")
            vc.dismiss(animated: true, completion: nil)
        }
        self.addAction(xmarkAction, for: .touchUpInside)
    }
}
