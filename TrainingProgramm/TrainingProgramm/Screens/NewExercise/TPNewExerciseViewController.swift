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
    private var inventory = [String]()
    
    public var onPrepared: (() -> Void)?
    
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
        onPrepared?()
    }
    
    // MARK: - Main Interface
    public func configure(with inventory: [String]) {
        self.inventory = inventory
        inventoryPickerView.refreshData()
    }
    
    public func configure(with training: TPExercise?) {
        guard let training = training else {
            return
        }
        nameTextInputView.text = training.name
        if let index = inventory.firstIndex(of: training.inventory ?? "") {
            inventoryPickerView.select(itemAt: index)
        }
        descriptionTextInputView.text = training.description
        videoTextInputView.text = training.video?.url.absoluteString
    }
}

// MARK: - Private Methods
private extension TPNewExerciseViewController {
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
        trainingListView = createTrainingList(superview: superview, topAnchor: addToTrainingTitle.bottomAnchor)
        
        trainingListView.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
    }
    
    func setupDelegates() {
        trainingListView.viewDelegate = self
        trainingListView.refreshData()
    }
    
    private func handleContentSizeChange() {
        rootScrollView.resizeContentSizeToFitChilds()
    }
}

extension TPNewExerciseViewController: TPDropdownListPickerDelegate {
    public func tpDropdownList(_ sender: TPDropdownList, openStatusChanged isOpened: Bool) {
        handleContentSizeChange()
    }
    
    public func tpDropdownList(_ sender: TPDropdownList, selectedItemAtIndex index: Int) {}
    
    public func tpDropdownList(_ sender: TPDropdownList, selectedTextInputItem item: String?) {}
    
    public func tpDropdownListItems(_ sender: TPDropdownList) -> [String] {
        return inventory
    }
    
    public func tpDropdownListConstraintAndRelativeViewToAnimateHeightChange(_ sender: TPDropdownList) -> [(NSLayoutConstraint, UIView)] {
        return [(inventoryPickerHeightConstraint, rootScrollView)]
    }
}

extension TPNewExerciseViewController: TPAddToTrainingListViewDelegate {
    public func tpAddToTrainingListViewItems(_ sender: TPAddToTrainingListView) -> [(String, Bool)] {
        return [("Training1", false), ("Training2", true)]
    }
    
    public func tpAddToTrainingListView(_ sender: TPAddToTrainingListView, checboxStatusChanged isChecked: Bool, atIndex index: Int) {
        
    }
}
