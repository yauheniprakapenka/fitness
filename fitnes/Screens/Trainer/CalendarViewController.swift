//
//  CalendarViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 08.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit
import FSCalendar // https://www.youtube.com/watch?v=FipNDF7g9tE

struct CalendarTrainingModel {
    var dayOfWeek: String
    var numberAndMonth: String
    var description: String
}

class CalendarViewController: UIViewController{
    
    var calendar: FSCalendar!
    var formatter = DateFormatter()
    let tableView = UITableView()
    
    let horisontalLineView = HorisontalLineView()
    
    let calendarTrainingModel: [CalendarTrainingModel] = [
        CalendarTrainingModel(dayOfWeek: "Среда", numberAndMonth: "6 августа", description: "Тренировка Пешком 3 км"),
        CalendarTrainingModel(dayOfWeek: "Четверг", numberAndMonth: "9 сентября", description: "Тренировка со скакалкой")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureNavigation()
        configureCalendar()
        configureHorisontalLineView()
        setupTableView()
    }
    
    private func configureCalendar() {
        calendar = FSCalendar(frame: CGRect(x: 0,y: 120, width: self.view.frame.size.width, height: 300))
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
        let cancelButton = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    private func configureHorisontalLineView() {
        view.addSubview(horisontalLineView)
        horisontalLineView.topAnchor.constraint(equalTo: view.topAnchor, constant: 440).isActive = true
        horisontalLineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        horisontalLineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        horisontalLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}

extension CalendarViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        formatter.dateFormat = "dd-MMM-yyyy"
        
        if formatter.string(from: date) == "20-Aug-2020" {
            print("да")
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
        return calendarTrainingModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CalendarTrainingCell
        
        cell.selectionStyle = .none
        cell.dayOfWeekLabel.text = calendarTrainingModel[indexPath.row].dayOfWeek
        cell.numberAndMonthLabel.text = calendarTrainingModel[indexPath.row].numberAndMonth
        cell.descriptionLabel.text = calendarTrainingModel[indexPath.row].description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}
