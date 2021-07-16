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
    // MARK: - Network
    private let authProvider = MoyaProvider<CharacterService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    private var characterModel: CharacterModel?
    
    private let authLookProvider = MoyaProvider<LookService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    var lookDetailModel: LookDetailModel?
    
    // MARK: - Lazy Properties
    /// image index, name, level
    lazy var naviBar = NavigationBar(vc: self, index: self.index, name: name, level: self.level)
    lazy var headerView = CharacterHeaderView(isDetail: isDetail)
    
    // MARK: - Properties
    let upperView = CharacterUpperView()
    let mainTableView = UITableView(frame: .zero, style: .plain)
    let reportCell = CharacterReportTVC()
    let firstCell = CharacterFirstTVC()
    var isDetail: Bool = false
    
    let catchGuideImageView = UIImageView().then {
        $0.image = UIImage(named: "imgCatchGuide")
    }
    
    // MARK: - Server Data
    var report: CharacterReportData?
    var characterData: CharacterDetail?
    var data: ActivityDetail?
    var lookData: LookActivityDetail?
    var posts = [ActivityDetail]()
    var index = 0
    var userId = ""
    var level = 0
    var name = ""
    var imageIndex = 0
    var nickname = ""
    var activityIndex = 0
    var detailReport: LookCharacterReportData?
    var lookPosts = [LookActivityDetail]()
    var colors: [UIColor] = [.back300, .back300, .back200, .back400, .back100, .back400, .back200, .back100]

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupAutoLayout()
        setupTableView()
                
        if isDetail {
            print("다른 사람들 구경하기 상세")
            fetchLookDetail()
            naviBar.editButton.isHidden = true
//            upperView.characterImageView.image = setCharacterImage(level: level, index: imageIndex, size: 151)
            headerView.dateLabel.text = nickname
            headerView.lockImageView.isHidden = true
//            headerView.writeButton.isHidden = true
            headerView.fromLabel.text = "님의"
            
        } else if isDetail == false {
            print("그냥 내 캐릭터 상세")
            fetchCharacterDetail() {
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if !isDetail {
            fetchCharacterDetail() {
                print("그냥 내 캐릭터 상세")
                self.mainTableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
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
        let vc = AddActionVC()
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let dateString = dateFormatter.string(from: now)
        
        vc.setLabel(text: dateString)
        
        if let level = self.report?.character.characterLevel,
           let imageIndex = self.report?.character.characterImageIndex,
           let index = self.report?.character.characterIndex {
            vc.catchu = self.setCharacterImage(level: level, index: imageIndex, size: 151)
//            vc.characterIndex = index
        }
        vc.name = report?.character.characterName
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate
extension CharacterVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            if let birth = self.report?.character.characterBirth {
                let yearStart = birth.index(birth.startIndex, offsetBy: 0)
                let yearEnd = birth.index(birth.endIndex, offsetBy: -10)
                let yearRange = yearStart..<yearEnd
                
                let monthStart = birth.index(birth.startIndex, offsetBy: 4)
                let monthEnd = birth.index(birth.endIndex, offsetBy: -8)
                let monthRange = monthStart..<monthEnd
                
                let dayStart = birth.index(birth.startIndex, offsetBy: 6)
                let dayEnd = birth.index(birth.endIndex, offsetBy: -6)
                let dayRange = dayStart..<dayEnd
                
                headerView.dateLabel.text = String(birth[yearRange]) + "." + String(birth[monthRange]) + "." + String(birth[dayRange])
            }
//            headerView.nameLabel.text = report?.character.characterName
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
                if posts.count < 4 {
                    return 600
                }
                return 300
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
                guard let reportCell = tableView.dequeueReusableCell(withIdentifier: "CharacterReportTVC", for: indexPath) as? CharacterReportTVC
                else { return UITableViewCell() }
                reportCell.selectionStyle = .none
                reportCell.setupAutoLayout()
                reportCell.catchGuideButton.addTarget(self, action: #selector(touchupCatchGuidebutton(_:)), for: .touchUpInside)
                if isDetail {
                    reportCell.setData(level: detailReport?.character.characterLevel, catchRate: detailReport?.catchRate, activity: detailReport?.characterActivitiesCount)
                } else if isDetail == false {
                    reportCell.setData(level: report?.character.characterLevel, catchRate: report?.catchRate, activity: report?.characterActivitiesCount)
                }
                return reportCell
            } else if indexPath.row == 1 { // 첫 번째 lineView가 안 붙여져 있는 cell
                guard let firstCell = tableView.dequeueReusableCell(withIdentifier: "CharacterFirstTVC", for: indexPath) as? CharacterFirstTVC
                else { return UITableViewCell() }
                firstCell.rootVC = self
                firstCell.selectionStyle = .none
                if posts.count == 0 {
                    firstCell.setupEmptyLayout()
                } else {
                    if isDetail {
                        firstCell.moreButton.isHidden = true
                        
                    }
                    firstCell.characterData = self.characterModel?.data.character
                    firstCell.upperView = upperView
                    firstCell.setupAutoLayout()
                    
                    if isDetail {
                        firstCell.lookData = lookPosts[0]
                        firstCell.setLookData()
                    } else {
                        firstCell.data = posts[0]
                        firstCell.setData()
                    }
                    
                    firstCell.emptyStateImageView.isHidden = true
                    firstCell.emptyStateLabel.isHidden = true
                }
                return firstCell
            } else { // 두 번째부터 lineView가 붙여져 있는 cell
                guard let restCell = tableView.dequeueReusableCell(withIdentifier: "CharacterTVC", for: indexPath) as? CharacterTVC
                else { return UITableViewCell() }
                if isDetail {
                    restCell.moreButton.isHidden = true
//                    restCell.data = lookPosts[indexPath.row-1]
//                    restCell.setData(date: String(lookPosts[indexPath.row-1].activityYear + "." lookPosts[indexPath.row-1].activityMonth + "." + lookPosts[indexPath.row-1].activityDay), comment: lookPosts[indexPath.row-1].activityContent, image: lookPosts[indexPath.row-1].activityImage)
                }
                restCell.rootVC = self
                restCell.characterData = self.characterModel?.data.character
                restCell.upperView = upperView
                restCell.selectionStyle = .none
                restCell.setupAutoLayout()
                restCell.data = posts[indexPath.row-1]
                restCell.setData()
                if posts[indexPath.row - 1].activityContent == "Dsdfs" {
                    print("asdasd", posts[indexPath.row - 1])
                }
                return restCell
            }
        default:
            return UITableViewCell()
        }
    }
}

extension CharacterVC {
    // MARK: - Network : fetchCharacterDetail
    func fetchCharacterDetail(completion: @escaping (() -> ())) {
        authProvider.request(.characterDetail(index)) { response in
            switch response {
            case .success(let result):
                do {
                    self.posts.removeAll()
                    
                    self.characterModel = try result.map(CharacterModel.self)
                    self.report = self.characterModel?.data
                    
                    if let data = self.characterModel?.data.character.activity {
                        self.posts = data
                    }
                    
                    if let level = self.report?.character.characterLevel,
                       let imageIndex = self.report?.character.characterImageIndex,
                       let privacy = self.report?.character.characterPrivacy,
                       let activity = self.report?.character.activity{
                        self.upperView.characterImageView.image = self.setCharacterImage(level: level, index: imageIndex, size: 151)
                        self.headerView.lockImageView.isHidden = !privacy
                        self.upperView.backgroundView.backgroundColor = self.colors[imageIndex - 1]
                        self.headerView.nameLabel.text = self.report?.character.characterName
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
    
    // MARK: - Network : fetchLookDetail
    func fetchLookDetail() {
        authLookProvider.request(.otherDetail(userId, index)) { response in
            switch response {
            case .success(let result):
                do {
                    self.lookPosts.removeAll()
                    self.lookDetailModel = try result.map(LookDetailModel.self)
                    
                    self.detailReport = self.lookDetailModel?.data
                    
                    if let data = self.lookDetailModel?.data.character.activity {
                        self.lookPosts = data
                    }
                    
                    if let level = self.detailReport?.character.characterLevel,
                       let imageIndex = self.detailReport?.character.characterImageIndex,
                       let privacy = self.detailReport?.character.characterPrivacy,
                       let name = self.detailReport?.character.characterName {
//                        self.upperView.characterImageView.image = self.setCharacterImage(level: level, index: imageIndex, size: 151)
                        self.headerView.lockImageView.isHidden = !privacy
//                        self.level = level
//                        self.name = name
//                        self.imageIndex = imageIndex
                        self.headerView.nameLabel.text = name
                        self.upperView.backgroundView.backgroundColor = self.colors[imageIndex - 1]
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
