//
//  CharacterVC.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/02.
//

import UIKit

import Then
import SnapKit

class CharacterVC: UIViewController {
    // MARK: - Lazy Properties
    lazy var naviBar = NavigationBar(vc: self)

    // MARK: - Properties
    let vc = CharacterPopupVC()
    let upperView = CharacterUpperView()
    let mainTableView = UITableView(frame: .zero, style: .plain)
    let moreMenuView = MoreMenuView()
    let reportCell = CharacterReportTVC()
    
    let catchGuideImageView = UIImageView().then {
//      $0.setImage(UIImage(named: ""), for: .normal)
        $0.backgroundColor = .purple
    }
    
    var posts = [Activity(date: "2021.05.01", comment: "와 너무 재밌다. 마트 다녀오셨어요? 네..? 와 너무 재밌다. 마트 다녀오셨어요? 네..?", image: "왕"),
                 Activity(date: "2021.05.01", comment: "와 너무 재밌다. 마트 다녀오셨어요? 네..? 와 너무 재밌다. 마트 다녀오셨어요? 네..?", image: "왕"),
                 Activity(date: "2021.05.01", comment: "와 너무 재밌다. 마트 다녀오셨어요? 네..? 와 너무 재밌다. 마트 다녀오셨어요? 네..?", image: "왕"),
                 Activity(date: "2021.05.01", comment: "와 너무 재밌다. 마트 다녀오셨어요? 네..? 와 너무 재밌다. 마트 다녀오셨어요? 네..?", image: "왕"),
                 Activity(date: "2021.05.01", comment: "와 너무 재밌다. 마트 다녀오셨어요? 네..? 와 너무 재밌다. 마트 다녀오셨어요? 네..?", image: "왕")]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAutoLayout()
        setTableView()
    }
    
    // MARK: - Custom Method
    func setTableView() {
        catchGuideImageView.isHidden = true
        mainTableView.backgroundColor = .black
        upperView.backgroundColor = .white
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        mainTableView.register(CharacterReportTVC.self, forCellReuseIdentifier: "CharacterReportTVC")
        mainTableView.register(CharacterTVC.self, forCellReuseIdentifier: "CharacterTVC")
        
        mainTableView.separatorStyle = .none
        
        mainTableView.tableFooterView = UIView(frame: .zero)
        mainTableView.sectionFooterHeight = 0
    }
    
    func setupAutoLayout() {
        view.addSubviews([mainTableView, upperView, naviBar, catchGuideImageView])
        
        naviBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        upperView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width)
        }
        
        mainTableView.snp.makeConstraints { make in
            make.top.equalTo(upperView.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
        }
        
        catchGuideImageView.snp.makeConstraints { make in
            make.top.equalTo(mainTableView.snp.top).inset(104)
            make.trailing.equalTo(view.snp.trailing).inset(28)
            make.width.equalTo(166)
            make.height.equalTo(58)
        }
    }
    
    @objc func touchupCatchGuidebutton(_ sender: UIButton) {
        if reportCell.catchGuideButton.isSelected == true {
            reportCell.catchGuideButton.isSelected = false
            catchGuideImageView.isHidden = true
        } else if reportCell.catchGuideButton.isSelected == false {
            reportCell.catchGuideButton.isSelected = true
            catchGuideImageView.isHidden = false
        }
    }

    @objc func touchupWriteButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Character", bundle: nil)
        guard let nextVC = storyboard.instantiateViewController(withIdentifier: "AddActionVC") as? AddActionVC else { return }
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true, completion: nil)
    }
    
    @objc func touchupEditButton(_ sender: UIButton) {
        // 편집VC로 화면 전환 코드 작성해야 함
    }
    
    @objc func touchupDeleteButton(_ sender: UIButton) {
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        let touch = touches.first
//        if touch?.view != self.catchGuideImageView {
//            catchGuideImageView.isHidden = true
//        }
//    }
}

// MARK: - UITableViewDelegate
extension CharacterVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CharacterHeaderView()
        headerView.writeButton.addTarget(self, action: #selector(touchupWriteButton(_:)), for: .touchUpInside)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 127
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = UIScreen.main.bounds.width
        let backgroundWidth = self.upperView.backgroundView.bounds.width
        let backgroundHeight = self.upperView.backgroundView.bounds.height
        let offset = scrollView.contentOffset.y
        
        if width - offset < 171 {
            UIView.animate(withDuration: 0.03) {
                self.upperView.characterImageView.transform = CGAffineTransform(scaleX: 65/150, y: 65/150).translatedBy(x: 0, y: -238)
                self.upperView.backgroundView.transform = CGAffineTransform(scaleX: 82/backgroundWidth, y: 82/backgroundHeight).translatedBy(x: 0, y: 203)

                // 헤더 부분 높이
                self.upperView.snp.updateConstraints { make in
                    make.height.equalTo(171)
                }
                // 핑크색 배경
                self.upperView.backgroundView.snp.updateConstraints { make in
                    make.width.equalTo(self.upperView.backgroundView.bounds.height)
                    make.height.equalTo(self.upperView.backgroundView.bounds.height)
                }
                // 핑크색 둥글기
                self.upperView.backgroundView.layer.cornerRadius = backgroundWidth / 2
            }
        } else {
            UIView.animate(withDuration: 0.1) {
                self.upperView.characterImageView.transform = .identity
                self.upperView.backgroundView.transform = .identity
                self.upperView.transform = .identity

                // 헤더 부분 높이
                self.upperView.snp.updateConstraints { make in
                    make.height.equalTo(width-offset)
                }
                // 캐릭터 상단 constraint
                self.upperView.characterImageView.snp.updateConstraints { make in
                    make.top.equalTo(158)
                }
                // 핑크색 둥글기
                self.upperView.backgroundView.layer.cornerRadius = 0
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension CharacterVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if posts.isEmpty == true {
                return 1 + 1
            } else {
                return 1 + posts.count
            }
        default:
            return Int()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                guard let reportCell = tableView.dequeueReusableCell(withIdentifier: "CharacterReportTVC", for: indexPath) as? CharacterReportTVC else { return UITableViewCell() }
                reportCell.setupAutoLayout()
                reportCell.selectionStyle = .none
                reportCell.catchGuideButton.addTarget(self, action: #selector(touchupCatchGuidebutton(_:)), for: .touchUpInside)
                return reportCell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTVC", for: indexPath) as? CharacterTVC else { return UITableViewCell() }
                cell.selectionStyle = .none
                if posts.count == 0 {
                    cell.emptySetupLayout()
                } else {
                    cell.setupAutoLayout()
                    cell.setData(date: posts[indexPath.row-1].date, comment: posts[indexPath.row-1].comment, image: posts[indexPath.row-1].image)
                    cell.moreMenuView.deleteButton.addTarget(self, action: #selector(touchupDeleteButton(_:)), for: .touchUpInside)
                }
                return cell
            }
        default:
            return UITableViewCell()
        }
    }
}
