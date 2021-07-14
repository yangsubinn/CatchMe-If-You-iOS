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
    
    let sectionList: [String] = ["닉네임 변경", "비밀번호 변경", "이용약관", "오픈소스 라이선스", "개발자 정보", "로그아웃", "서비스 탈퇴"]

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configUI()
        setupTableView()
    }

    //MARK: - Custom Method
    func setupLayout() {
        view.addSubviews([backButton, titleLabel, settingTableView])
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(55)
            make.leading.equalToSuperview().offset(14)
            make.width.height.equalTo(48)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(66)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(backButton.snp.centerY)
        }
        
        settingTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.trailing.leading.equalToSuperview().inset(28)
            make.bottom.equalToSuperview()
        }
    }
    
    func configUI() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.backgroundColor = .black100
        
        titleLabel.text = "설정"
        titleLabel.textColor = .white
        titleLabel.font = .stringBoldSystemFont(ofSize: 20)
    }
    
    func setupTableView() {
        settingTableView.dataSource = self
        settingTableView.delegate = self
        
        settingTableView.register(SettingTVC.self, forCellReuseIdentifier: "SettingTVC")
        
        settingTableView.backgroundColor = .clear
        settingTableView.separatorStyle = .none
        settingTableView.tableFooterView = UIView(frame: .zero)
        settingTableView.sectionFooterHeight = 0
        settingTableView.isScrollEnabled = false
    }
}

// MARK: - UITableViewDelegate
extension SettingVC: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            guard let vc = storyboard?.instantiateViewController(identifier: "EditNicknameVC") as? EditNicknameVC else { return }
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            guard let vc = storyboard?.instantiateViewController(identifier: "EditPasswordVC") as? EditPasswordVC else { return }
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            break
        case 3:
            break
        case 4:
            break
        case 5:
            guard let vc = storyboard?.instantiateViewController(identifier: "LogoutVC") as? LogoutVC else { return }
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            present(vc, animated: true, completion: nil)
        default:
            break
        }
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTVC", for: indexPath) as? SettingTVC else {return UITableViewCell()}
        
        cell.layer.cornerRadius = 10
        cell.textLabel?.text = "\(sectionList[indexPath.section])"
        cell.backgroundColor = .black200
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = .stringRegularSystemFont(ofSize: 16)
        
        cell.selectionStyle = .none

        return cell
    }
}
