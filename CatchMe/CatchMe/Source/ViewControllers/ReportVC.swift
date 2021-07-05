//
//  ReportVC.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/02.
//

import UIKit

import SnapKit

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
    let dummyFormatter = DateFormatter()
    var dummyDate: [String] = ["2021-09-13", "2021-08-31", "2021-07-17", "2021-06-15", "2021-06-16", "2021-06-17", "2021-06-18", "2021-06-25", "2021-10-31"]
    var monthDate: [String] = []
    var dayAndYear = ""
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupCalendar()
        makeMonthDate()
        calculateCalendarDate()
        setupCollectionView()
        setupLayout()
        setupButtonAction()
    }

    // MARK: - Custom Methods
    fileprivate func configUI() {
        /// 색상 들어오면 변경할 것
        view.backgroundColor = .black
        setupStatusBar(.systemPink)
        
        /// asset 들어오면 asset으로 변경할 것
        previousButton.backgroundColor = .systemGray
        nextButton.backgroundColor = .systemGray
    }
    
    fileprivate func setupCollectionView() {
        weekdayFlowLayout.scrollDirection = .vertical
        dateFlowLayout.scrollDirection = .vertical
        
        weekdayCollectionView.delegate = self
        weekdayCollectionView.dataSource = self
        weekdayCollectionView.register(CalendarCVC.self, forCellWithReuseIdentifier: CalendarCVC.identifier)
        weekdayCollectionView.backgroundColor = .black
        weekdayCollectionView.isScrollEnabled = false
        
        dateCollectionView.delegate = self
        dateCollectionView.dataSource = self
        dateCollectionView.register(CalendarCVC.self, forCellWithReuseIdentifier: CalendarCVC.identifier)
        dateCollectionView.backgroundColor = .black
        dateCollectionView.isScrollEnabled = false
    }
    
    private func setupLayout() {
        view.addSubviews([reportView, backButton, calendarTitleView,
                          previousButton, nextButton, weekdayCollectionView,
                          dateCollectionView])
        
        reportView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.size.height * 0.41)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(55)
            make.leading.equalToSuperview().inset(14)
        }
        
        calendarTitleView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(reportView.snp.bottom).offset(37)
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
            make.top.equalTo(calendarTitleView.snp.bottom).offset(14)
            make.height.equalTo(43)
        }
        
        dateCollectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(weekdayCollectionView.snp.bottom).offset(8)
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
        dummyFormatter.dateFormat = "YYYY"
        dayAndYear = ""
        
        let firstDayOfMonth = Calendar.current.date(from: components)
        
        /// title 부분 year 설정
        dateFormatter.dateFormat = "YYYY"
        let year = dateFormatter.string(from: firstDayOfMonth!)
        calendarTitleView.applyYearLabel(to: year)
        
        /// title 부분 month 설정
        dateFormatter.dateFormat = "M"
        let titleMonth = dateFormatter.string(from: firstDayOfMonth!)
        calendarTitleView.applyMonthLabel(to: titleMonth)
        
        /// dummyDate를 위한 month 설정
        dateFormatter.dateFormat = "MM"
        let month = dateFormatter.string(from: firstDayOfMonth!)
        
        for date in dummyDate {
            let string = date.split(separator: "-")
            
            if string[0] == year && string[1] == month {
                let day = (string[2] as NSString).integerValue
                monthDate.append("\(day)")
            }
        }
    }
}

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
            
            cell.dataLabel.text = weeks[indexPath.row]
            cell.dataLabel.font = UIFont.systemFont(ofSize: 15)
            cell.dataLabel.textColor = .darkGray
            
            return cell
            
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCVC.identifier, for: indexPath) as? CalendarCVC else {
                return UICollectionViewCell()
            }
            
            cell.dataLabel.text = days[indexPath.row]
            cell.dataLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
            cell.dataLabel.textColor = .white
            
            if !monthDate.isEmpty {
                if monthDate[0] == days[indexPath.row] {
                    cell.characterImage.isHidden = false
                    cell.countLabel.text = days[indexPath.row]
                    cell.countLabel.textColor = .systemGray
                    cell.countLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
                    cell.dataLabel.isHidden = true
                    monthDate.removeFirst()
                } else {
                    cell.dataLabel.isHidden = false
                    cell.characterImage.isHidden = true
                    cell.countLabel.text = ""
                }
            } else {
                cell.dataLabel.isHidden = false
                cell.characterImage.isHidden = true
                cell.countLabel.text = ""
            }
            
            return cell
        }
    }
}

extension ReportVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let boundSize = UIScreen.main.bounds.size.width - 32 - 24
        var cellSize = 0
        
        switch collectionView {
        case weekdayCollectionView:
            cellSize = Int(boundSize / 7)
            return CGSize(width: cellSize,
                            height: 43)
        default:
            cellSize = Int(boundSize / 7)
            return CGSize(width: cellSize,
                            height: 51)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
