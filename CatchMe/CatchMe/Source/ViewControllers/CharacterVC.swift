//
//  CharacterVC.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/02.
//

import UIKit

import Moya
import Then
import SnapKit


class CharacterVC: UIViewController {
    private let authProvider = MoyaProvider<CharacterService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    private var characterModel: CharacterModel?
    
    // MARK: - Lazy Properties
    lazy var naviBar = NavigationBar(vc: self)
    
    // MARK: - Properties
    let upperView = CharacterUpperView()
    let mainTableView = UITableView(frame: .zero, style: .plain)
    let reportCell = CharacterReportTVC()
    let firstCell = CharacterFirstTVC()
    
    let catchGuideImageView = UIImageView().then {
        $0.image = UIImage(named: "imgCatchGuide")
    }
    
    var report: CharacterReportData?
    var posts = [ActivityDetail]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupAutoLayout()
        setupTableView()
        fetchCharacterDetail()
    }
    
    // MARK: - Custom Method
    func configUI() {
        upperView.backgroundColor = .black100
        catchGuideImageView.isHidden = true
    }
    
    func setupTableView() {
        mainTableView.backgroundColor = .black100
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
            make.width.equalTo(189)
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
        nextVC.setLabel(text: "2021.07.14")
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate
extension CharacterVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let headerView = CharacterHeaderView()
            headerView.lockImageView.isHidden = ((report?.character.characterPrivacy) != nil)
            headerView.dateLabel.text = report?.character.characterBirth
            headerView.nameLabel.text = report?.character.characterName
            headerView.makeShadow(.black, 0.15, CGSize(width: 0, height: 6), 8)
            headerView.writeButton.addTarget(self, action: #selector(touchupWriteButton(_:)), for: .touchUpInside)
            return headerView
        default:
            if posts.isEmpty {
                return nil
            } else {
                let footerView = CharacterFooterView()
                return footerView
            }
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
        reportCell.catchGuideButton.isSelected = false
        catchGuideImageView.isHidden = true
        
        let width = UIScreen.main.bounds.width
        let backgroundWidth = self.upperView.backgroundView.bounds.width
        let backgroundHeight = self.upperView.backgroundView.bounds.height
        let offset = scrollView.contentOffset.y
        
        if width - offset < 171 {
            UIView.animate(withDuration: 0.1) {
                self.upperView.characterImageView.transform = CGAffineTransform(scaleX: 65/150, y: 65/150).translatedBy(x: 0, y: -238)
                self.upperView.backgroundView.transform = CGAffineTransform(scaleX: 81/backgroundWidth, y: 81/backgroundHeight).translatedBy(x: 0, y: 203)
                
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
                reportCell.setData(level: report?.character.characterLevel, catchRate: report?.catchRate, activity: report?.characterActivitiesCount)
                return reportCell
            } else if indexPath.row == 1 { // 첫 번째 lineView가 안 붙여져 있는 cell
                guard let firstCell = tableView.dequeueReusableCell(withIdentifier: "CharacterFirstTVC", for: indexPath) as? CharacterFirstTVC else { return UITableViewCell() }
                firstCell.rootVC = self
                firstCell.selectionStyle = .none
                if posts.count == 0 {
                    firstCell.setupEmptyLayout()
                } else {
                    firstCell.setupAutoLayout()
                    firstCell.data = posts[0]
                    firstCell.setData()
                    firstCell.emptyStateImageView.isHidden = true
                    firstCell.emptyStateLabel.isHidden = true
                }
                return firstCell
            } else { // 두 번째부터 lineView가 붙여져 있는 cell
                guard let restCell = tableView.dequeueReusableCell(withIdentifier: "CharacterTVC", for: indexPath) as? CharacterTVC else { return UITableViewCell() }
                restCell.rootVC = self
                restCell.selectionStyle = .none
                restCell.setupAutoLayout()
                restCell.data = posts[indexPath.row-1]
                restCell.setData()
                return restCell
            }
        default:
            return UITableViewCell()
        }
    }
}

extension CharacterVC {
    // MARK: - Network
    func fetchCharacterDetail() {
        authProvider.request(.characterDetail(2)) { response in
            switch response {
            case .success(let result):
                do {
                    self.characterModel = try result.map(CharacterModel.self)
                    self.report = self.characterModel?.data
                    self.posts.append(contentsOf: self.characterModel?.data.character.activity ?? [])
                    self.posts.reverse()
                    
                    print("@@@@",self.report?.character)
                    if let index = self.report?.character.characterLevel,
                       let imageIndex = self.report?.character.characterImageIndex {
                        print("보이세요????~?~!~!~!~~~~₩₩~₩₩₩₩")
                        print("----------------------------------------------")
                        print(index)
                        print(imageIndex)

                        print("----------------------------------------------")
                        self.upperView.characterImageView.image = self.setCharacterImage(level: index, index: imageIndex, size: 151)
                    }

                    self.mainTableView.reloadData()
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
