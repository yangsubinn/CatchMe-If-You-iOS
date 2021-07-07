//
//  SettingVC.swift
//  CatchMe
//
//  Created by 양수빈 on 2021/07/07.
//

import UIKit

import SnapKit

class SettingVC: UIViewController {
    //MARK: - Properties
    lazy var backButton = BackButton(self)
    let titleLabel = UILabel()
    let settingTableView = UITableView(frame: .zero, style: .plain)
    
    private let sectionList: [String] = ["닉네임 변경", "비밀번호 변경", "이용약관", "오픈소스 라이선스", "로그아웃", "서비스 탈퇴"]

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configUI()
        setTableView()
    }

    //MARK: - Custom Method
    func setupLayout() {
        view.addSubviews([backButton, titleLabel, settingTableView])
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(55)
            make.leading.equalTo(view.snp.leading).offset(14)
            make.width.height.equalTo(48)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(66)
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(backButton.snp.centerY)
        }
        
        settingTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(28)
            make.trailing.equalToSuperview().inset(28)
            make.bottom.equalToSuperview()
        }
    }
    
    func configUI() {
        view.backgroundColor = .black100
        
        backButton.backgroundColor = .blue100
        
        titleLabel.text = "설정"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.stringBoldSystemFont(ofSize: 20)
    }
    
    func setTableView() {
        settingTableView.backgroundColor = .clear
        
        settingTableView.dataSource = self
        settingTableView.delegate = self
        
        settingTableView.register(SettingTVC.self, forCellReuseIdentifier: "SettingTVC")
        
        settingTableView.separatorStyle = .none
        settingTableView.tableFooterView = UIView(frame: .zero)
        settingTableView.sectionFooterHeight = 0
    }
}

// MARK: - UITableViewDelegate
extension SettingVC: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Value: \(sectionList[indexPath.section])")
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    /// 테이블 셀들간의 간격 조정하는 곳
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 16
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

// MARK: - UITableViewDataSource
extension SettingVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTVC", for: indexPath)
        
        cell.layer.cornerRadius = 10
        
        cell.textLabel?.text = "\(sectionList[indexPath.section])"
        cell.backgroundColor = .black200
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = .stringRegularSystemFont(ofSize: 16)

        return cell
    }
}
