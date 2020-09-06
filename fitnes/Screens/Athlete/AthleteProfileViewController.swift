//
//  AthleteParameterViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 07.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

struct TitleForCategory {
    var title: String
}

class AthleteProfileViewController: UIViewController {
    
    var scrollView: UIScrollView!
    let tableView = UITableView()
    
    let titleLabel = FLabel(fontSize: 18, weight: .semibold, color: .black, message: "Мои параметры")
    let cancelButton = FButtonSimple(title: "Отмена", titleColor: .gray, size: 14)
    let saveButton = FButtonSimple(title: "Сохранить", titleColor: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), size: 14)
    
    let fioLabel = FLabel(fontSize: 16, weight: .semibold, color: .black, message: "ФИО")
    let fioTextField = FTextField(placeholderText: "ФИО", placeholderColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    
    let phoneLabel = FLabel(fontSize: 16, weight: .semibold, color: .black, message: "Телефон")
    let phoneTextField = FTextField(placeholderText: "Телефон", placeholderColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    
    let indicatorLabel = FLabel(fontSize: 16, weight: .semibold, color: .black, message: "Показатели")
    let indicatorTextField = FTextField(placeholderText: "Показатели", placeholderColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    
    let titleForCategoryLabel = FLabel(fontSize: 16, weight: .semibold, color: .black, message: "Заголовок для категории")
    
    let leadTimeLabel = FLabel(fontSize: 18, weight: .semibold, color: .black, message: "Время выполнения комплексов (мин.)")
    
    let franLabel = FLabel(fontSize: 16, weight: .regular, color: .black, message: "Fran")
    
    let fran10Button = FButtonFran(title: "10")
    let fran20Button = FButtonFran(title: "20")
    let fran30Button = FButtonFran(title: "30")
    let fran40Button = FButtonFran(title: "40")
    let fran50Button = FButtonFran(title: "50")
    let fran60Button = FButtonFran(title: "60")
    
    var isfran10ButtonSelected = false
    var isfran20ButtonSelected = false
    var isfran30ButtonSelected = false
    var isfran40ButtonSelected = false
    var isfran50ButtonSelected = false
    var isfran60ButtonSelected = false
    
    var countGrace = 15
    
    let graceLabel = FLabel(fontSize: 15, weight: .regular, color: .black, message: "Grace")
    let plusButton = FButtonFran(title: "+")
    let countLabel = FLabel(fontSize: 16, weight: .semibold, color: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), message: "nil")
    let minusButton = FButtonFran(title: "-")
    
    let titleForCategory: [TitleForCategory] = [
        TitleForCategory(title: "Одноповторные максимумы"),
        TitleForCategory(title: "Толчок тяжелоатлетический"),
        TitleForCategory(title: "Рывок тяжелоатлетический"),
        TitleForCategory(title: "Становая тяга"),
        TitleForCategory(title: "Бег 400 метров"),
        TitleForCategory(title: "Бег 5000 метров"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureScrollView()
        configureTitleLabel()
        configureCancelButton()
        configureSaveButton()
        
        configureFioLabel()
        configureFioTextField()
        configurePhoneLabel()
        configurePhoneTextField()
        configureIndicatorLabel()
        configureIndicatorTextField()
        configureTitleForCategoryLabel()
        
        setupTableView()
        
        configureLeadTimeLabel()
        configureFranLabel()
        
        configureFran10Button()
        configureFran20Button()
        configureFran30Button()
        configureFran40Button()
        configureFran50Button()
        configureFran60Button()
        
        configureGraceLabel()
        configurePlusButton()
        configureCountLabel()
        configureMinusButton()
        
        countLabel.text = String(countGrace)
    }
    
    private func configureScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: UIScreen.main.bounds.height * 3.2)
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.backgroundColor = .white
    }
    
    private func configureTitleLabel() {
        scrollView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func configureCancelButton() {
        scrollView.addSubview(cancelButton)
        cancelButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
        
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    private func configureSaveButton() {
        scrollView.addSubview(saveButton)
        saveButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc private func saveButtonTapped() {
        print(#function)
    }
    
    private func configureFioLabel() {
        scrollView.addSubview(fioLabel)
        fioLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60).isActive = true
        fioLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        fioLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }
    
    private func configureFioTextField() {
        scrollView.addSubview(fioTextField)
        fioTextField.topAnchor.constraint(equalTo: fioLabel.bottomAnchor, constant: 20).isActive = true
        fioTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        fioTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        fioTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func configurePhoneLabel() {
        scrollView.addSubview(phoneLabel)
        phoneLabel.topAnchor.constraint(equalTo: fioTextField.bottomAnchor, constant: 40).isActive = true
        phoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    }
    
    private func configurePhoneTextField() {
        scrollView.addSubview(phoneTextField)
        phoneTextField.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 20).isActive = true
        phoneTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        phoneTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        phoneTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func configureIndicatorLabel() {
        scrollView.addSubview(indicatorLabel)
        
        indicatorLabel.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 40).isActive = true
        indicatorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    }
    
    private func configureIndicatorTextField() {
        scrollView.addSubview(indicatorTextField)
        indicatorTextField.topAnchor.constraint(equalTo: indicatorLabel.bottomAnchor, constant: 20).isActive = true
        indicatorTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        indicatorTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        indicatorTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func configureTitleForCategoryLabel() {
        scrollView.addSubview(titleForCategoryLabel)
        titleForCategoryLabel.topAnchor.constraint(equalTo: indicatorTextField.bottomAnchor, constant: 40).isActive = true
        titleForCategoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    }
    
    private func configureLeadTimeLabel() {
        scrollView.addSubview(leadTimeLabel)
        leadTimeLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20).isActive = true
        leadTimeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    }
    
    private func configureFranLabel() {
        scrollView.addSubview(franLabel)
        franLabel.topAnchor.constraint(equalTo: leadTimeLabel.bottomAnchor, constant: 20).isActive = true
        franLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    }
    
}

extension AthleteProfileViewController: UITableViewDelegate {
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = #colorLiteral(red: 0.9803171754, green: 0.9804343581, blue: 0.9802773595, alpha: 1)
        
        scrollView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: titleForCategoryLabel.bottomAnchor, constant: 20).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 300).isActive = true // tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.register(TitleAndCheckboxCell.self, forCellReuseIdentifier: "cell")
    }
}

extension AthleteProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleForCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TitleAndCheckboxCell
        cell.selectionStyle = .none
        cell.nameLabel.text = titleForCategory[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}

// MARK: - Sorry for this horror. Im refactor it later
extension AthleteProfileViewController {
    
    private func configureFran10Button() {
        let squareSize: CGFloat = 35
        scrollView.addSubview(fran10Button)
        fran10Button.topAnchor.constraint(equalTo: franLabel.bottomAnchor, constant: 20).isActive = true
        fran10Button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        fran10Button.widthAnchor.constraint(equalToConstant: squareSize).isActive = true
        fran10Button.heightAnchor.constraint(equalToConstant: squareSize).isActive = true
        
        fran10Button.addTarget(self, action: #selector(fran10ButtonTapped), for: .touchUpInside)
    }
    
    @objc private func fran10ButtonTapped() {
        isfran10ButtonSelected = !isfran10ButtonSelected
        
        if isfran10ButtonSelected {
            fran10Button.setTitleColor(.white, for: .normal)
            fran10Button.backgroundColor = #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1)
        } else {
            fran10Button.setTitleColor(#colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), for: .normal)
            fran10Button.backgroundColor = .white
        }
    }
    
    private func configureFran20Button() {
        let squareSize: CGFloat = 35
        scrollView.addSubview(fran20Button)
        fran20Button.topAnchor.constraint(equalTo: franLabel.bottomAnchor, constant: 20).isActive = true
        fran20Button.leadingAnchor.constraint(equalTo: fran10Button.trailingAnchor, constant: 20).isActive = true
        fran20Button.widthAnchor.constraint(equalToConstant: squareSize).isActive = true
        fran20Button.heightAnchor.constraint(equalToConstant: squareSize).isActive = true
        
        fran20Button.addTarget(self, action: #selector(fran20ButtonTapped), for: .touchUpInside)
    }
    
    @objc private func fran20ButtonTapped() {
        isfran20ButtonSelected = !isfran20ButtonSelected
        
        if isfran20ButtonSelected {
            fran20Button.setTitleColor(.white, for: .normal)
            fran20Button.backgroundColor = #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1)
        } else {
            fran20Button.setTitleColor(#colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), for: .normal)
            fran20Button.backgroundColor = .white
        }
    }
    
    private func configureFran30Button() {
        let squareSize: CGFloat = 35
        scrollView.addSubview(fran30Button)
        fran30Button.topAnchor.constraint(equalTo: franLabel.bottomAnchor, constant: 20).isActive = true
        fran30Button.leadingAnchor.constraint(equalTo: fran20Button.trailingAnchor, constant: 20).isActive = true
        fran30Button.widthAnchor.constraint(equalToConstant: squareSize).isActive = true
        fran30Button.heightAnchor.constraint(equalToConstant: squareSize).isActive = true
        
        fran30Button.addTarget(self, action: #selector(fran30ButtonTapped), for: .touchUpInside)
    }
    
    @objc private func fran30ButtonTapped() {
        isfran30ButtonSelected = !isfran30ButtonSelected
        
        if isfran30ButtonSelected {
            fran30Button.setTitleColor(.white, for: .normal)
            fran30Button.backgroundColor = #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1)
        } else {
            fran30Button.setTitleColor(#colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), for: .normal)
            fran30Button.backgroundColor = .white
        }
    }
    
    private func configureFran40Button() {
        let squareSize: CGFloat = 35
        scrollView.addSubview(fran40Button)
        fran40Button.topAnchor.constraint(equalTo: franLabel.bottomAnchor, constant: 20).isActive = true
        fran40Button.leadingAnchor.constraint(equalTo: fran30Button.trailingAnchor, constant: 20).isActive = true
        fran40Button.widthAnchor.constraint(equalToConstant: squareSize).isActive = true
        fran40Button.heightAnchor.constraint(equalToConstant: squareSize).isActive = true
        
        fran40Button.addTarget(self, action: #selector(fran40ButtonTapped), for: .touchUpInside)
    }
    
    @objc private func fran40ButtonTapped() {
        isfran40ButtonSelected = !isfran40ButtonSelected
        
        if isfran40ButtonSelected {
            fran40Button.setTitleColor(.white, for: .normal)
            fran40Button.backgroundColor = #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1)
        } else {
            fran40Button.setTitleColor(#colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), for: .normal)
            fran40Button.backgroundColor = .white
        }
    }
    
    private func configureFran50Button() {
        let squareSize: CGFloat = 35
        scrollView.addSubview(fran50Button)
        fran50Button.topAnchor.constraint(equalTo: franLabel.bottomAnchor, constant: 20).isActive = true
        fran50Button.leadingAnchor.constraint(equalTo: fran40Button.trailingAnchor, constant: 20).isActive = true
        fran50Button.widthAnchor.constraint(equalToConstant: squareSize).isActive = true
        fran50Button.heightAnchor.constraint(equalToConstant: squareSize).isActive = true
        
        fran50Button.addTarget(self, action: #selector(fran50ButtonTapped), for: .touchUpInside)
    }
    
    @objc private func fran50ButtonTapped() {
        isfran50ButtonSelected = !isfran50ButtonSelected
        
        if isfran50ButtonSelected {
            fran50Button.setTitleColor(.white, for: .normal)
            fran50Button.backgroundColor = #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1)
        } else {
            fran50Button.setTitleColor(#colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), for: .normal)
            fran50Button.backgroundColor = .white
        }
    }
    
    private func configureFran60Button() {
        let squareSize: CGFloat = 35
        scrollView.addSubview(fran60Button)
        fran60Button.topAnchor.constraint(equalTo: franLabel.bottomAnchor, constant: 20).isActive = true
        fran60Button.leadingAnchor.constraint(equalTo: fran50Button.trailingAnchor, constant: 20).isActive = true
        fran60Button.widthAnchor.constraint(equalToConstant: squareSize).isActive = true
        fran60Button.heightAnchor.constraint(equalToConstant: squareSize).isActive = true
        
        fran60Button.addTarget(self, action: #selector(fran60ButtonTapped), for: .touchUpInside)
    }
    
    @objc private func fran60ButtonTapped() {
        isfran60ButtonSelected = !isfran60ButtonSelected
        
        if isfran60ButtonSelected {
            fran60Button.setTitleColor(.white, for: .normal)
            fran60Button.backgroundColor = #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1)
        } else {
            fran60Button.setTitleColor(#colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), for: .normal)
            fran60Button.backgroundColor = .white
        }
    }
}

// MARK: - Sorry for this horror. Im refactor it later
extension AthleteProfileViewController {
    
    private func configureGraceLabel() {
        scrollView.addSubview(graceLabel)
        graceLabel.topAnchor.constraint(equalTo: fran10Button.bottomAnchor, constant: 40).isActive = true
        graceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    }
    
    private func configurePlusButton() {
        scrollView.addSubview(plusButton)
        plusButton.topAnchor.constraint(equalTo: fran10Button.bottomAnchor, constant: 40).isActive = true
        plusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        plusButton.setTitleColor(.gray, for: .normal)
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }
    
    @objc private func plusButtonTapped() {
        countGrace += 1
        countLabel.text = String(countGrace)
    }
    
    private func configureCountLabel() {
        scrollView.addSubview(countLabel)
        countLabel.topAnchor.constraint(equalTo: fran10Button.bottomAnchor, constant: 37).isActive = true
        countLabel.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: -20).isActive = true
        countLabel.widthAnchor.constraint(equalToConstant: 44).isActive = true
        countLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        countLabel.layer.cornerRadius = 5
        countLabel.layer.borderWidth = 1
        countLabel.layer.borderColor = #colorLiteral(red: 0.8940489888, green: 0.8941563964, blue: 0.8940123916, alpha: 1)
        countLabel.textAlignment = .center
    }
    
    private func configureMinusButton() {
        scrollView.addSubview(minusButton)
        minusButton.topAnchor.constraint(equalTo: fran10Button.bottomAnchor, constant: 40).isActive = true
        minusButton.trailingAnchor.constraint(equalTo: countLabel.leadingAnchor, constant: -20).isActive = true
        
        minusButton.setTitleColor(.gray, for: .normal)
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
    }
    
    @objc private func minusButtonTapped() {
        countGrace -= 1
        countLabel.text = String(countGrace)
    }
}
