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
        let scrollView = createRootScrollView(superview: view)
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
        if let index = inventory.firstIndex(of: training.inventory) {
            inventoryPickerView.select(itemAt: index)
        }
        descriptionTextInputView.text = training.description
        videoTextInputView.text = training.video?.url.absoluteString
    }
}

private extension TPNewExerciseViewController {
    func makeConstraints(to view: UIView, topAnchor: NSLayoutYAxisAnchor, topOffset: CGFloat) {
        guard let superview = view.superview else {
            fatalError("No superview")
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: topAnchor, constant: topOffset).isActive = true
        view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: Const.offsetLeftRightAllFields).isActive = true
        view.widthAnchor.constraint(equalTo: superview.widthAnchor, constant: -2 * Const.offsetLeftRightAllFields).isActive = true
    }
    
    func createRootScrollView(superview: UIView) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(scrollView)
        let layoutGuide = superview.safeAreaLayoutGuide
        scrollView.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        return scrollView
    }
    
    func createTitleLabel(superview: UIView, text: String, topAnchor: NSLayoutYAxisAnchor, topOffet: CGFloat) -> UILabel {
        let label = UILabel()
        superview.addSubview(label)
        makeConstraints(to: label, topAnchor: topAnchor, topOffset: topOffet)
        label.text = text
        label.decorator.apply(Const.titleLabelDecoration)
        return label
    }
    
    func createInputField(superview: UIView, placeholderText: String, topAnchor: NSLayoutYAxisAnchor, topOffset: CGFloat) -> TPTextInputView {
        let input = TPTextInputView()
        superview.addSubview(input)
        makeConstraints(to: input, topAnchor: topAnchor, topOffset: topOffset)
        input.placeholderText = placeholderText
        return input
    }
    
    func createInventoryPicker(superview: UIView, topAnchor: NSLayoutYAxisAnchor) -> (TPDropdownList, NSLayoutConstraint) {
        let picker = TPDropdownList()
        picker.inputViewLeftConstraint.constant = 0
        picker.inputViewRightConstraint.constant = 0
        picker.placeholderText = "Введите имя или выберите"
        superview.addSubview(picker)
        makeConstraints(to: picker, topAnchor: topAnchor, topOffset: Const.offsetTopInputFields)
        let heightConstraint = picker.heightAnchor.constraint(equalToConstant: 55)
        heightConstraint.isActive = true
        return (picker, heightConstraint)
    }
    
    func createTrainingList(superview: UIView, topAnchor: NSLayoutYAxisAnchor) -> (TPAddToTrainingListView) {
        let list = TPAddToTrainingListView()
        superview.addSubview(list)
        makeConstraints(to: list, topAnchor: topAnchor, topOffset: 15)
        list.leftOffset = 0
        list.rightOffset = 0
        list.spacing = 10
        return list
    }
    
    func createContentViews(addTo superivew: UIView) {
        let nameLabel = createTitleLabel(
            superview: superivew,
            text: "Название",
            topAnchor: superivew.topAnchor,
            topOffet: Const.offsetTopTitleFirst)
        nameTextInputView = createInputField(
            superview: superivew,
            placeholderText: "Введите название",
            topAnchor: nameLabel.bottomAnchor,
            topOffset: Const.offsetTopInputFields)
        let inventoryTypeTitle = createTitleLabel(
            superview: superivew,
            text: "Тип инвертаря",
            topAnchor: nameTextInputView.bottomAnchor,
            topOffet: Const.offsetTopTitleOthers)
        let (picker, pickerHeightConstraint) = createInventoryPicker(superview: superivew, topAnchor: inventoryTypeTitle.bottomAnchor)
        inventoryPickerView = picker
        inventoryPickerView.viewPickerDelegate = self
        inventoryPickerHeightConstraint = pickerHeightConstraint
        let descriptionTitle = createTitleLabel(
            superview: superivew,
            text: "Описание",
            topAnchor: inventoryPickerView.bottomAnchor,
            topOffet: Const.offsetTopTitleOthers)
        descriptionTextInputView = createInputField(
            superview: superivew,
            placeholderText: "Введите краткое описание",
            topAnchor: descriptionTitle.bottomAnchor,
            topOffset: Const.offsetTopInputFields)
        let videoTitle = createTitleLabel(
            superview: superivew,
            text: "Видео",
            topAnchor: descriptionTextInputView.bottomAnchor,
            topOffet: Const.offsetTopTitleOthers)
        videoTextInputView = createInputField(
            superview: superivew,
            placeholderText: "Вставьте ссылку",
            topAnchor: videoTitle.bottomAnchor,
            topOffset: Const.offsetTopInputFields)
        let addToTrainingTitle = createTitleLabel(
            superview: superivew,
            text: "Добавить в тренировку",
            topAnchor: videoTextInputView.bottomAnchor,
            topOffet: Const.offsetTopTitleOthers)
        trainingListView = createTrainingList(superview: superivew, topAnchor: addToTrainingTitle.bottomAnchor)
        trainingListView.bottomAnchor.constraint(equalTo: superivew.bottomAnchor).isActive = true
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
    
    public func tpDropdownListConstraintAndRelativeViewToAnimateHeightChange(_ sender: TPDropdownList) -> (NSLayoutConstraint, UIView)? {
        return (inventoryPickerHeightConstraint, rootScrollView)
    }
}

extension TPNewExerciseViewController: TPAddToTrainingListViewDelegate {
    public func tpAddToTrainingListViewItems(_ sender: TPAddToTrainingListView) -> [(String, Bool)] {
        return [("Training1", false), ("Training2", true)]
    }
    
    public func tpAddToTrainingListView(_ sender: TPAddToTrainingListView, checboxStatusChanged isChecked: Bool, atIndex index: Int) {
        
    }
}
