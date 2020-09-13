//
//  TPNewExerciseViewController.swift
//  TrainingProgramm
//
//  Created by Vitali on 9/2/20.
//

// swiftlint:disable function_body_length

import UIKit
import CommonViews

private extension TPNewExerciseViewController {
    enum Const {
        static let titleLabelDecoration: Decoration<UILabel> = { label in
            label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            label.textColor = Asset.TrainingProgramm.CommonColors.tpBlackText.color
        }
        static let offsetTopTitleFirst: CGFloat = 38
        static let offsetTopTitleOthers: CGFloat = 25
        static let offsetTopInputFields: CGFloat = 15
        static let offsetLeftRightAllFields: CGFloat = 25
    }
}

public extension TPNewExerciseViewController {
    typealias OnSaveHandler = () -> Void
}

public class TPNewExerciseViewController: UIViewController {
    // MARK: - Views
    private weak var rootScrollView: UIScrollView!
    private weak var nameTextInputView: TPTextInputView!
    private weak var inventoryPickerView: TPDropdownList!
    private weak var descriptionTextInputView: TPTextInputView!
    private weak var videoTextInputView: TPTextInputView!
    private weak var trainingListView: TPAddToTrainingListView!
    
    // MARK: - Constraints
    private weak var inventoryPickerHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    public var onSaveHandler: OnSaveHandler?
    public var inventory = [String]()
    public var exercise: TPExercise = TPExercise()
    public var service: TPExercisesService?
    
    // MARK: - Lifecycle
    public override func loadView() {
        super.loadView()
        let scrollView = TPFormControllerUtils.createRootScrollView(superview: view)
        rootScrollView = scrollView
        view.backgroundColor = .white
        createContentViews(addTo: scrollView)
        setupDelegates()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        handleContentSizeChange()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        navigationController?.isNavigationBarHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem?.title = "Сохранить"
        configureSaveEnabled()
    }
    
    // MARK: - Main Interface
    public func configure(with inventory: [String]) {
        self.inventory = inventory
        inventoryPickerView.refreshData()
    }
    
    public func configure() {
        nameTextInputView.text = exercise.name
        if let index = inventory.firstIndex(of: exercise.inventory ?? "") {
            inventoryPickerView.select(itemAt: index)
        }
        descriptionTextInputView.text = exercise.description
        videoTextInputView.text = exercise.video?.url.absoluteString
    }
    
    // MARK: - Action and Action Callabacks
    @objc
    private func saveButtonTapped() {
        service?.addExercise(exercise, completion: { result in
            self.onSaveHandler?()
            switch result {
            case .success:
                self.navigationController?.popViewController(animated: true)
            case .failure:
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
}

// MARK: - Private Methods
private extension TPNewExerciseViewController {
    func configureSaveEnabled() {
        let valid = exercise.name != nil && exercise.inventory != nil
        navigationItem.rightBarButtonItem?.isEnabled = valid
    }
    
    func createInventoryPicker(superview: UIView, topAnchor: NSLayoutYAxisAnchor) -> (TPDropdownList, NSLayoutConstraint) {
        let picker = TPDropdownList()
        picker.inputViewLeftConstraint.constant = 0
        picker.inputViewRightConstraint.constant = 0
        picker.placeholderText = "Введите имя или выберите"
        superview.addSubview(picker)
        TPFormControllerUtils.makeConstraints(to: picker, topAnchor: topAnchor, topOffset: Const.offsetTopInputFields)
        let heightConstraint = picker.heightAnchor.constraint(equalToConstant: 55)
        heightConstraint.isActive = true
        return (picker, heightConstraint)
    }
    
    func createTrainingList(superview: UIView, topAnchor: NSLayoutYAxisAnchor) -> (TPAddToTrainingListView) {
        let list = TPAddToTrainingListView()
        superview.addSubview(list)
        TPFormControllerUtils.makeConstraints(to: list, topAnchor: topAnchor, topOffset: 15)
        list.leftOffset = 0
        list.rightOffset = 0
        list.spacing = 10
        return list
    }
    
    func createContentViews(addTo superview: UIView) {
        let nameLabel = TPFormControllerUtils.createTitleLabel(
            superview: superview,
            text: "Название",
            topAnchor: superview.topAnchor,
            topOffet: Const.offsetTopTitleFirst)
        nameTextInputView = TPFormControllerUtils.createInputField(
            superview: superview,
            placeholderText: "Введите название",
            topAnchor: nameLabel.bottomAnchor,
            topOffset: Const.offsetTopInputFields)
        let inventoryTypeTitle = TPFormControllerUtils.createTitleLabel(
            superview: superview,
            text: "Тип инвертаря",
            topAnchor: nameTextInputView.bottomAnchor,
            topOffet: Const.offsetTopTitleOthers)
        let (picker, pickerHeightConstraint) = createInventoryPicker(superview: superview, topAnchor: inventoryTypeTitle.bottomAnchor)
        inventoryPickerView = picker
        inventoryPickerView.viewPickerDelegate = self
        inventoryPickerHeightConstraint = pickerHeightConstraint
        let descriptionTitle = TPFormControllerUtils.createTitleLabel(
            superview: superview,
            text: "Описание",
            topAnchor: inventoryPickerView.bottomAnchor,
            topOffet: Const.offsetTopTitleOthers)
        descriptionTextInputView = TPFormControllerUtils.createInputField(
            superview: superview,
            placeholderText: "Введите краткое описание",
            topAnchor: descriptionTitle.bottomAnchor,
            topOffset: Const.offsetTopInputFields)
        let videoTitle = TPFormControllerUtils.createTitleLabel(
            superview: superview,
            text: "Видео",
            topAnchor: descriptionTextInputView.bottomAnchor,
            topOffet: Const.offsetTopTitleOthers)
        videoTextInputView = TPFormControllerUtils.createInputField(
            superview: superview,
            placeholderText: "Вставьте ссылку",
            topAnchor: videoTitle.bottomAnchor,
            topOffset: Const.offsetTopInputFields)
        let addToTrainingTitle = TPFormControllerUtils.createTitleLabel(
            superview: superview,
            text: "Добавить в тренировку",
            topAnchor: videoTextInputView.bottomAnchor,
            topOffet: Const.offsetTopTitleOthers)
        addToTrainingTitle.isHidden = true
        trainingListView = createTrainingList(superview: superview, topAnchor: addToTrainingTitle.bottomAnchor)
        trainingListView.isHidden = true
        trainingListView.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
    }
    
    func setupDelegates() {
        trainingListView.viewDelegate = self
        trainingListView.refreshData()
        nameTextInputView.viewDelegate = self
        descriptionTextInputView.viewDelegate = self
        videoTextInputView.viewDelegate = self
    }
    
    private func handleContentSizeChange() {
        rootScrollView.resizeContentSizeToFitChilds()
    }
}

extension TPNewExerciseViewController: TPDropdownListPickerDelegate {
    public func tpDropdownList(_ sender: TPDropdownList, openStatusChanged isOpened: Bool) {
        handleContentSizeChange()
    }
    
    public func tpDropdownList(_ sender: TPDropdownList, selectedItemAtIndex index: Int) {
        exercise.inventory = inventory[index]
        configureSaveEnabled()
    }
    
    public func tpDropdownList(_ sender: TPDropdownList, selectedTextInputItem item: String?) {}
    
    public func tpDropdownListItems(_ sender: TPDropdownList) -> [String] {
        return inventory
    }
    
    public func tpDropdownListNeedAnimateHeight(_ sender: TPDropdownList, heightDelta: CGFloat, animationDuration: TimeInterval) {
        UIView.animate(withDuration: animationDuration, animations: {
            self.inventoryPickerHeightConstraint.constant += heightDelta
            self.rootScrollView.layoutIfNeeded()
        })
    }
}

extension TPNewExerciseViewController: TPAddToTrainingListViewDelegate {
    public func tpAddToTrainingListViewItems(_ sender: TPAddToTrainingListView) -> [(String, Bool)] {
        return [("Training1", false), ("Training2", true)]
    }
    
    public func tpAddToTrainingListView(_ sender: TPAddToTrainingListView, checboxStatusChanged isChecked: Bool, atIndex index: Int) {
        
    }
}

extension TPNewExerciseViewController: TPTextInputViewDelegate {
    public func tpTextInputViewShouldReturn(_ sender: TPTextInputView) -> Bool {
        return true
    }
    
    public func tpTextInputViewDidBeginEditing(_ sender: TPTextInputView) {}
    
    public func tpTextInputViewDidEndEditing(_ sender: TPTextInputView, byReturn: Bool) {
        switch sender {
        case nameTextInputView:
            exercise.name = sender.text
            configureSaveEnabled()
        case descriptionTextInputView:
            exercise.description = sender.text
            configureSaveEnabled()
        case videoTextInputView:
            if let url = URL(string: sender.text ?? "") {
                exercise.video = .remote(url: url)
                configureSaveEnabled()
            }
        default:
            return
        }
    }
    
    public func tpTextInputViewTextChanged(_ sender: TPTextInputView, changedText: String?) {}
}
