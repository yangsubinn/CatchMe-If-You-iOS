//
//  ThirdFlowView.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/08.
//

import UIKit

class ThirdFlowView: UIView {
    // MARK: - Properties
    let titleView = CatchuTitleView(title: "새로운 캐츄가 태어났어요!", subTitle: "내 안에 방금 생겨난 캐츄를 확인하세요")
    let characterImageView = UIImageView(image: UIImage(named: ""))
    let backgroundImageView = UIImageView(image: UIImage(named: ""))
    let nameLabel = UILabel()
    let lockLabel = UILabel()
    let lockButton = UIButton()
    
    var textCount = 0
    
    // MARK: - Dummy Data
    /// 후에 enum으로 사용하면 편리할 듯 -> 아니면 public하게 전체적으로 사용할 수 있도록 만들기
    let colors: [UIColor] = [.systemRed, .systemBlue, .systemPink, .systemTeal, .systemGray, .systemGreen, .systemOrange, .systemYellow, .systemPurple, .systemIndigo]

    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Methods
    private func setupLayout() {
        addSubviews([titleView, characterImageView, backgroundImageView,
                     nameLabel, lockLabel, lockButton])
        
        titleView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(28)
        }
        
        characterImageView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(UIScreen.main.hasNotch ? 175 : 115)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(150)
        }
    }
    
    private func configUI() {
        
    }
    
    func setImageViewColor(selectedIndex: Int) {
        characterImageView.backgroundColor = colors[selectedIndex]
    }
}
