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
    let upperView = CharacterUpperView()
    let mainTableView = UITableView(frame: .zero, style: .plain)
    let reportCell = CharacterReportTVC()
    
    let catchGuideImageView = UIImageView().then {
//      $0.setImage(UIImage(named: ""), for: .normal)
        $0.backgroundColor = .purple
    }
    
    var posts = [Activity(date: "2021.05.01", comment: "캐치미사랑해?", image: "왕"),
                 Activity(date: "2021.05.01", comment: "위얼 줌보걸즈 위얼 줌보걸즈 위얼 줌보걸즈", image: "왕"),
                 Activity(date: "2021.05.01", comment: "와 너무 재밌다. 마트 다녀오셨어요? 네..? 와 너무 재밌다. 마트 다녀오셨어요? 네..?", image: "왕"),
                 Activity(date: "2021.05.01", comment: "왜 다를까? 킹이 받아용 왜 다를까? 킹이 받아용 왜 다를까? 킹이 받아용", image: "왕"),
                 Activity(date: "2021.05.01", comment: "캐치미 너무 너무 조아욜~! 뷰가 킹받는데.. 오카징. 재사용 나가!", image: "왕")]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupAutoLayout()
        setupTableView()
    }
    
    // MARK: - Custom Method
    func configUI() {
        upperView.backgroundColor = .black
        catchGuideImageView.isHidden = true
    }
    
    func setupTableView() {
        mainTableView.backgroundColor = .black
        mainTableView.separatorStyle = .none
        mainTableView.contentInsetAdjustmentBehavior = .never
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        mainTableView.register(CharacterReportTVC.self, forCellReuseIdentifier: "CharacterReportTVC")
        mainTableView.register(CharacterFirstTVC.self, forCellReuseIdentifier: "CharacterFirstTVC")
        mainTableView.register(CharacterTVC.self, forCellReuseIdentifier: "CharacterTVC")
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
        if reportCell.catchGuideButton.isSelected {
            reportCell.catchGuideButton.isSelected = false
            catchGuideImageView.isHidden = true
        } else {
            reportCell.catchGuideButton.isSelected = true
            catchGuideImageView.isHidden = false
        }
    }
    
    @objc func touchupWriteButton(_ sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "AddActionVC") as? AddActionVC else { return }
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true, completion: nil)
    }
    
    @objc func touchupMoreButton(_ sender: UIButton) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        let alertViewController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertViewController.view.tintColor = .white
        
        if let actionSheet = alertViewController.view.subviews.first,
           let secondSheet = alertViewController.view.subviews.last {
            for innerView in actionSheet.subviews {
                innerView.backgroundColor = .black300
                innerView.layer.cornerRadius = 18.0
                innerView.clipsToBounds = true
            }
            for innerView in secondSheet.subviews {
                innerView.backgroundColor = .black300
                innerView.layer.cornerRadius = 18.0
                innerView.clipsToBounds = true
            }
        }
        
        let editAction = UIAlertAction(title: "수정", style: .default) { result in
            // 편집VC로 화면 전환 코드 작성해야 함
        }
        
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { result in
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "CharacterPopupVC") as? CharacterPopupVC else { return }
            
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
        }
        
        deleteAction.setValue(UIColor.red100, forKey: "titleTextColor")
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alertViewController.addAction(editAction)
        alertViewController.addAction(deleteAction)
        alertViewController.addAction(cancelAction)
        
        self.present(alertViewController, animated: true, completion: nil)
    }
    
// 캐치지수 팝업 관련 코드입니다.
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
        switch section {
        case 0:
            let headerView = CharacterHeaderView()
            headerView.writeButton.addTarget(self, action: #selector(touchupWriteButton(_:)), for: .touchUpInside)
            return headerView
        default:
            let footerView = CharacterFooterView()
            return footerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 127
        default:
            if posts.isEmpty {
                return 0
            } else {
                return 112
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = UIScreen.main.bounds.width
        let backgroundWidth = self.upperView.backgroundView.bounds.width
        let backgroundHeight = self.upperView.backgroundView.bounds.height
        let offset = scrollView.contentOffset.y
        
        if width - offset < 171 {
            UIView.animate(withDuration: 0.1) {
                self.upperView.characterImageView.transform = CGAffineTransform(scaleX: 65/150, y: 65/150).translatedBy(x: 0, y: -238)
                self.upperView.backgroundView.transform = CGAffineTransform(scaleX: 82/backgroundWidth, y: 82/backgroundHeight).translatedBy(x: 0, y: 203)
                
                // 헤더 부분 높이
                self.upperView.snp.updateConstraints { make in
                    make.height.equalTo(171)
                }
                // 핑크색 배경
                self.upperView.backgroundView.snp.updateConstraints { make in
                    make.width.height.equalTo(self.upperView.backgroundView.bounds.height)
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
                    make.height.equalTo(width - offset)
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
            if posts.isEmpty {
                return 1 + 1 // reportCell + emptySetupLayout인 경우 emptyState 때문에 무조건 줘야 하는 것
            } else {
                return 1 + posts.count // reportCell + empty가 아닌 경우
            }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                guard let reportCell = tableView.dequeueReusableCell(withIdentifier: "CharacterReportTVC", for: indexPath) as? CharacterReportTVC else { return UITableViewCell() }
                reportCell.selectionStyle = .none
                reportCell.setupAutoLayout()
                reportCell.catchGuideButton.addTarget(self, action: #selector(touchupCatchGuidebutton(_:)), for: .touchUpInside)
                return reportCell
            } else if indexPath.row == 1 { // 첫 번째 lineView가 안 붙여져 있는 cell
                guard let firstCell = tableView.dequeueReusableCell(withIdentifier: "CharacterFirstTVC", for: indexPath) as? CharacterFirstTVC else { return UITableViewCell() }
                firstCell.selectionStyle = .none
                if posts.count == 0 {
                    firstCell.setupEmptyLayout()
                } else {
                    firstCell.setupAutoLayout()
                    firstCell.setData(date: posts[0].date, comment: posts[0].comment, image: posts[0].image)
                    firstCell.moreButton.addTarget(self, action: #selector(touchupMoreButton(_:)), for: .touchUpInside)
                }
                return firstCell
            } else { // 두 번째부터 lineView가 붙여져 있는 cell
                guard let restCell = tableView.dequeueReusableCell(withIdentifier: "CharacterTVC", for: indexPath) as? CharacterTVC else { return UITableViewCell() }
                restCell.selectionStyle = .none
                if posts.count == 0 {
                    restCell.setupEmptyLayout()
                } else {
                    restCell.setupAutoLayout()
                    restCell.moreButton.addTarget(self, action: #selector(touchupMoreButton(_:)), for: .touchUpInside)
                    restCell.setData(date: posts[indexPath.row-1].date, comment: posts[indexPath.row-1].comment, image: posts[indexPath.row-1].image)
                }
                return restCell
            }
        default:
            return UITableViewCell()
        }
    }
}
