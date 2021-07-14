//
//  ReportVC.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/02.
//

import UIKit

import SnapKit
import Moya

class ReportVC: UIViewController {
    // MARK: - lazy Properties
    lazy var backButton = BackButton(self)
    lazy var weekdayCollectionView = UICollectionView(frame: .zero, collectionViewLayout: weekdayFlowLayout)
    lazy var dateCollectionView = UICollectionView(frame: .zero, collectionViewLayout: dateFlowLayout)
    
    // MARK: - Properties
    let reportView = ReportView()
    let calendarTitleView = CalendarTitleView()
    let previousButton = UIButton()
    let nextButton = UIButton()
    let weekdayFlowLayout = UICollectionViewFlowLayout()
    let dateFlowLayout = UICollectionViewFlowLayout()
    let dateFormatter = DateFormatter()
    
    var components = DateComponents()
    var weeks: [String] = [ "일", "월", "화", "수", "목", "금", "토" ]
    var days: [String] = []
    var daysCountInMonth = 0
    var weekdayAdding = 0
    
    // MARK: - Dummy Data
    let viewModel = ReportViewModel.shared
    var activites: [ActivitiesOfMonth] = []
    var indexs: [Int] = []
    var levels: [Int] = []
    var monthDate: [String] = []
    var dayAndYear = ""
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupCollectionView()
        setupLayout()
        setupButtonAction()
        setupCalendar()
        makeMonthDate()
        calculateCalendarDate()
    }

    // MARK: - Custom Method
    fileprivate func configUI() {
        view.backgroundColor = .black100
        setupStatusBar(.pink100)
        
        previousButton.setImage(UIImage(named: "directionLeftColorWhite"), for: .normal)
        nextButton.setImage(UIImage(named: "directionRightColorWhite"), for: .normal)
    }
    
    fileprivate func setupCollectionView() {
        weekdayFlowLayout.scrollDirection = .vertical
        dateFlowLayout.scrollDirection = .vertical
        
        weekdayCollectionView.delegate = self
        weekdayCollectionView.dataSource = self
        weekdayCollectionView.register(CalendarCVC.self, forCellWithReuseIdentifier: CalendarCVC.identifier)
        weekdayCollectionView.backgroundColor = .black100
        weekdayCollectionView.isScrollEnabled = false
        
        dateCollectionView.delegate = self
        dateCollectionView.dataSource = self
        dateCollectionView.register(CalendarCVC.self, forCellWithReuseIdentifier: CalendarCVC.identifier)
        dateCollectionView.backgroundColor = .black100
        dateCollectionView.isScrollEnabled = false
    }
    
    private func setupLayout() {
        view.addSubviews([reportView, backButton, calendarTitleView,
                          previousButton, nextButton, weekdayCollectionView,
                          dateCollectionView])
        
        reportView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIScreen.main.hasNotch ? 0 : -10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.hasNotch ? UIScreen.main.bounds.size.height * 0.41 : 290)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIScreen.main.hasNotch ? 55 : 41)
            make.leading.equalToSuperview().inset(UIScreen.main.hasNotch ? 14 : 3)
        }
        
        calendarTitleView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(reportView.snp.bottom).offset(UIScreen.main.hasNotch ? 37 : 11)
        }
        
        previousButton.snp.makeConstraints { make in
            make.height.width.equalTo(48)
            make.leading.equalToSuperview().inset(8)
            make.centerY.equalTo(calendarTitleView.snp.centerY)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.width.equalTo(48)
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalTo(calendarTitleView.snp.centerY)
        }
        
        weekdayCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(calendarTitleView.snp.bottom).offset(UIScreen.main.hasNotch ? 14 : 11)
            make.height.equalTo(UIScreen.main.hasNotch ? 43 : 34)
        }
        
        dateCollectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(weekdayCollectionView.snp.bottom).offset(UIScreen.main.hasNotch ? 8 : 0)
        }
    }
    
    private func setupButtonAction() {
        let previousAction = UIAction { _ in
            self.components.month = self.components.month! - 1
            self.calculateCalendarDate()
            self.makeMonthDate()
            self.dateCollectionView.reloadData()
        }
        previousButton.addAction(previousAction, for: .touchUpInside)
        
        let nextAction = UIAction { _ in
            self.components.month = self.components.month! + 1
            self.calculateCalendarDate()
            self.makeMonthDate()
            self.dateCollectionView.reloadData()
        }
        nextButton.addAction(nextAction, for: .touchUpInside)
    }
    
    private func setupCalendar() {
        components.year = Calendar.current.component(.year, from: Date())
        components.month = Calendar.current.component(.month, from: Date())
        components.day = 1
    }
    
    private func calculateCalendarDate() {
        let firstDayOfMonth = Calendar.current.date(from: components)
        let firstWeekday = Calendar.current.component(.weekday, from: firstDayOfMonth!)
        daysCountInMonth = Calendar.current.range(of: .day,
                                        in: .month,
                                        for: firstDayOfMonth!)!.count
        
        weekdayAdding = 2 - firstWeekday
        
        dateFormatter.dateFormat = "YYYY"
        calendarTitleView.applyYearLabel(to: dateFormatter.string(from: Date()))
        dateFormatter.dateFormat = "M"
        calendarTitleView.applyMonthLabel(to: dateFormatter.string(from: Date()))
        
        self.days.removeAll()
        for day in weekdayAdding...daysCountInMonth {
            if day < 1 {
                self.days.append("")
            } else {
                self.days.append(String(day))
            }
        }
    }
    
    private func makeMonthDate() {
        monthDate.removeAll()
        
        let firstDayOfMonth = Calendar.current.date(from: components)
        
        /// title 부분 year 설정
        dateFormatter.dateFormat = "YYYY"
        let year = dateFormatter.string(from: firstDayOfMonth!)
        calendarTitleView.applyYearLabel(to: year)
        
        /// title 부분 month 설정
        dateFormatter.dateFormat = "M"
        let titleMonth = dateFormatter.string(from: firstDayOfMonth!)
        calendarTitleView.applyMonthLabel(to: titleMonth)
        
        /// Server 연결을 위한 month 설정
        dateFormatter.dateFormat = "MM"
        let month = dateFormatter.string(from: firstDayOfMonth!)
        
        dayAndYear = year + "." + month
        
        if let intYear = Int(year),
           let intMonth = Int(month) {
            fetchData(year: intYear, month: intMonth)
        }
    }
    
    func fetchData(year: Int, month: Int) {
        viewModel.fetchReport(year: year, month: month) { data in
            self.reportView.setCharacterView(data: data)
            
            if let months = data?.activitiesOfMonth {
                self.indexs.append(contentsOf: data?.characterIndexArr ?? [])
                self.levels.append(contentsOf: data?.characterLevelArr ?? [])
                self.activites.append(contentsOf: months)
                
                for i in months {
                    self.monthDate += [i.activityMonth]
                }
                
                let removedDuplicate: Set = Set(self.monthDate)
                self.monthDate = removedDuplicate.sorted()
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension ReportVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section:Int) -> Int {
        switch collectionView {
        case weekdayCollectionView:
            return 7
        default:
            return days.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case weekdayCollectionView:
            guard let cell = weekdayCollectionView.dequeueReusableCell(withReuseIdentifier: CalendarCVC.identifier, for: indexPath) as? CalendarCVC else {
                return UICollectionViewCell()
            }
            
            cell.dateLabel.text = weeks[indexPath.row]
            cell.dateLabel.font = .stringRegularSystemFont(ofSize: 15)
            cell.dateLabel.textColor = .gray200
            
            return cell
            
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCVC.identifier, for: indexPath) as? CalendarCVC else {
                return UICollectionViewCell()
            }
            
            cell.dateLabel.text = days[indexPath.row]
            cell.dateLabel.font = .numberMediumSystemFont(ofSize: 18)
            cell.dateLabel.textColor = .gray500
            
            if !monthDate.isEmpty {
                if monthDate[0] == days[indexPath.row] {
                    cell.characterImage.image = Character.orange.getCharacterImage(phase: 3, size: 43)
                    cell.characterImage.isHidden = false
                    cell.countLabel.text = days[indexPath.row]
                    cell.countLabel.textColor = .gray400
                    cell.countLabel.font = .numberRegularSystemFont(ofSize: 13)
                    cell.dateLabel.isHidden = true
                    monthDate.removeFirst()
                } else {
                    cell.dateLabel.isHidden = false
                    cell.characterImage.isHidden = true
                    cell.countLabel.text = ""
                }
            } else {
                cell.dateLabel.isHidden = false
                cell.characterImage.isHidden = true
                cell.countLabel.text = ""
            }
            
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ReportVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let boundSize = UIScreen.main.bounds.size.width - 32 - 24
        var cellSize = 0
        
        switch collectionView {
        case weekdayCollectionView:
            cellSize = Int(boundSize / 7)
            return CGSize(width: cellSize, height: UIScreen.main.hasNotch ? 43 : 34)
        default:
            cellSize = Int(boundSize / 7)
            return CGSize(width: cellSize, height: UIScreen.main.hasNotch ? 51 : 48)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return UIScreen.main.hasNotch ? 3 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

// MARK: - UICollectionViewDelegate
extension ReportVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let currentCell = collectionView.cellForItem(at: indexPath) as? CalendarCVC else { return }
        
        /// 이벤트가 일어난 날짜에만 터치 이벤트가 일어날 수 있도록
        if currentCell.characterImage.isHidden == false {
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "ReportPopupVC") as? ReportPopupVC else { return }
            
            if let text = currentCell.dateLabel.text {
                var newText = ""
                if text.count == 1 {
                    newText = ".0\(text)"
                } else {
                    newText = ".\(text)"
                }
                vc.date = dayAndYear + newText
            }
            
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true, completion: nil)
        }
    }
}
