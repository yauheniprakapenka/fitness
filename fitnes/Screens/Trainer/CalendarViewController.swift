//
//  CalendarViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 08.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit
import FSCalendar

// FSCalendar tutorial - https://www.youtube.com/watch?v=FipNDF7g9tE
// NSDateFormatter - https://nsdateformatter.com/

struct CalendarTrainingModel {
    var date: String
    var description: String
}

class CalendarViewController: UIViewController{
    
    var calendar: FSCalendar!
    var formatter = DateFormatter()
    let tableView = UITableView()
    
    let horisontalLineView = HorisontalLineView()
    
    let calendarTrainingModel: [CalendarTrainingModel] = [
        CalendarTrainingModel(date: "Sunday-16-Aug-2020", description: "C 10 до 18 - Тренировка «Пешком в Мордор». Взять кольца и провизию"),
        CalendarTrainingModel(date: "Monday-17-Aug-2020", description: "C 16 до 19 - Отрабатываем наклоны"),
        CalendarTrainingModel(date: "Tuesday-18-Aug-2020", description: "C 15 до 22 - Езда на велосипеде"),
        CalendarTrainingModel(date: "Wednesday-19-Aug-2020",  description: "C 13 до 23 - Бег 400 метров, тренировка с канатом, езда на велосипеде, прыжки на батуте"),
        CalendarTrainingModel(date: "Friday-21-Aug-2020", description: "C 10 до 18 - Тренировка «Пешком в Мордор». Взять кольца и провизию"),
        CalendarTrainingModel(date: "Monday-24-Aug-2020", description: "C 16 до 19 - Отрабатываем наклоны"),
        CalendarTrainingModel(date: "Wednesday-26-Aug-2020", description: "C 15 до 22 - Езда на велосипеде"),
        CalendarTrainingModel(date: "Friday-28-Aug-2020", description: "C 13 до 23 - Бег 400 метров, тренировка с канатом, езда на велосипеде, прыжки на батуте"),
    ]
    
    var filteredCalendarTrainingModel: [CalendarTrainingModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureNavigation()
        configureCalendar()
        configureHorisontalLineView()
        setupTableView()
    }
    
    private func configureCalendar() {
        calendar = FSCalendar(frame: CGRect(x: 0,y: 90, width: self.view.frame.size.width, height: 300))
        calendar.scrollDirection = .horizontal
        calendar.scope = .month
        calendar.locale = Locale(identifier: "ru")
        
        view.addSubview(calendar)
        calendar.translatesAutoresizingMaskIntoConstraints = false
        
        calendar.delegate = self
        calendar.dataSource = self
    }
    
    private func configureView() {
        view.backgroundColor = .white
    }
    
    private func configureNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Расписание тренера"
        
        let cancelButton = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    private func configureHorisontalLineView() {
        view.addSubview(horisontalLineView)
        horisontalLineView.topAnchor.constraint(equalTo: view.topAnchor, constant: 410).isActive = true
        horisontalLineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        horisontalLineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        horisontalLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}

extension CalendarViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        formatter.dateFormat = "EEEE-dd-MMM-yyyy"
        print(formatter.string(from: date))
        
        filteredCalendarTrainingModel = calendarTrainingModel.filter({$0.date.contains(formatter.string(from: date))})
        
        if filteredCalendarTrainingModel.count > 0 {
            if formatter.string(from: date) == filteredCalendarTrainingModel[0].date {
                print("совпало")
                print(filteredCalendarTrainingModel)
                tableView.reloadData()
            }
        } else {
            print("не совпало")
            filteredCalendarTrainingModel = []
            tableView.reloadData()
        }
    }
}

extension CalendarViewController: FSCalendarDataSource {
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
}

extension CalendarViewController: UITableViewDelegate {
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = #colorLiteral(red: 0.9803171754, green: 0.9804343581, blue: 0.9802773595, alpha: 1)
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: horisontalLineView.bottomAnchor, constant: 20).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.register(CalendarTrainingCell.self, forCellReuseIdentifier: "cell")
    }
}

extension CalendarViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCalendarTrainingModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CalendarTrainingCell
        
        cell.selectionStyle = .none
        cell.dayOfWeekLabel.text = DayOfWeekConverter.shared.convert(date: filteredCalendarTrainingModel[indexPath.row].date)
        cell.numberOfDayLabel.text = NumberOfDayConverter.shared.convert(date: filteredCalendarTrainingModel[indexPath.row].date)
        cell.monthLabel.text = MonthConverter.shared.convert(date: filteredCalendarTrainingModel[indexPath.row].date)
        cell.descriptionLabel.text = filteredCalendarTrainingModel[indexPath.row].description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
}
