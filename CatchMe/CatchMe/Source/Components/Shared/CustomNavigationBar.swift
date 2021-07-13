//
//  CustomNavigationBar.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/10.
//

import UIKit

import Then
import SnapKit

class CustomNavigationBar: UIView {
    // MARK: - Lazy Properties
    lazy var backButton = BackButton(vc ?? UIViewController())
    
    // MARK: - Properties
    let titleLabel = UILabel().then {
        $0.font = .stringBoldSystemFont(ofSize: 20)
    }
    
    var vc: UIViewController?

    // MARK: - Life Cycle
    init(_ vc: UIViewController, title: String) {
        super.init(frame: .zero)
        self.vc = vc
        configUI(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(13)
            make.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton.snp.centerY)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Custom Method
    private func configUI(title: String) {
        addSubviews([backButton, titleLabel])
        
        backgroundColor = .black100
        
        titleLabel.text = title
    }
}
