//
//  TPNewTrainingViewController.swift
//  TrainingProgramm
//
//  Created by Vitali on 9/5/20.
//

import UIKit
import CommonViews

private extension TPNewTrainingViewController {
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

public class TPNewTrainingViewController: UIViewController {
    // MARK: - Views
    private weak var rootScrollView: UIScrollView!
    private weak var nameTextInputView: TPTextInputView!
    private weak var descriptionTextInputView: TPTextInputView!
    private weak var timePickerView: TPTimePickerView!
    private weak var emomList: TPEmomSectionsListView!
    
    // MARK: - Constraints
    private weak var trainingTimePickerHeightConstraint: NSLayoutConstraint!

    // MARK: - Properties
    
    // MARK: - Lifecycle
    public override func loadView() {
        super.loadView()
        let scrollView = TPFormControllerUtils.createRootScrollView(superview: view)
        rootScrollView = scrollView
        view.backgroundColor = .white
        createContentViews(addTo: rootScrollView)
        setupDelegates()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        handleContentSizeChange()
    }
}

private extension TPNewTrainingViewController {
    func handleContentSizeChange() {
        rootScrollView.resizeContentSizeToFitChilds()
    }
    
    func createContentViews(addTo superview: UIView) {
        let nameLabel = TPFormControllerUtils.createTitleLabel(
            superview: superview,
            text: "Название тренировки",
            topAnchor: superview.topAnchor,
            topOffet: Const.offsetTopTitleFirst)
        nameTextInputView = TPFormControllerUtils.createInputField(
            superview: superview,
            placeholderText: "Введите название",
            topAnchor: nameLabel.bottomAnchor,
            topOffset: Const.offsetTopInputFields)
        let descriptionTitle = TPFormControllerUtils.createTitleLabel(
            superview: superview,
            text: "Описание",
            topAnchor: nameTextInputView.bottomAnchor,
            topOffet: Const.offsetTopTitleOthers)
        descriptionTextInputView = TPFormControllerUtils.createInputField(
            superview: superview,
            placeholderText: "Введите описание",
            topAnchor: descriptionTitle.bottomAnchor,
            topOffset: Const.offsetTopInputFields)
        let startTimeLabel = TPFormControllerUtils.createTitleLabel(
            superview: superview,
            text: "Время начала",
            topAnchor: descriptionTextInputView.bottomAnchor,
            topOffet: Const.offsetTopTitleOthers)
        (timePickerView, trainingTimePickerHeightConstraint) = createTimePicker(superview: superview, topAnchor: startTimeLabel.bottomAnchor)
        
        let addSectionHolder = TPAddSectionViewHolder(superview: superview)
        addSectionHolder.topAnchor.constraint(equalTo: timePickerView.bottomAnchor, constant: 20).isActive = true
        
        emomList = createEmomSectionList(superview: superview, topAnchor: addSectionHolder.bottomAnchor)
        emomList.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
    }
    
    func createTimePicker(superview: UIView, topAnchor: NSLayoutYAxisAnchor) -> (TPTimePickerView, NSLayoutConstraint) {
        let picker = TPTimePickerView()
        superview.addSubview(picker)
        picker.timeViewLeftConstraint.constant = 0
        TPFormControllerUtils.makeConstraints(to: picker, topAnchor: topAnchor, topOffset: Const.offsetTopInputFields)
        let heightConstraint = picker.heightAnchor.constraint(equalToConstant: 55)
        heightConstraint.isActive = true
        return (picker, heightConstraint)
    }
    
    func createEmomSectionList(superview: UIView, topAnchor: NSLayoutYAxisAnchor) -> TPEmomSectionsListView {
        let list = TPEmomSectionsListView()
        superview.addSubview(list)
        TPFormControllerUtils.makeConstraints(to: list, topAnchor: topAnchor, topOffset: Const.offsetTopInputFields, leftRight: 0)
        return list
    }
    
    func setupDelegates() {
        timePickerView.viewDelegate = self
        emomList.viewDelegate = self
        emomList.refreshData()
    }
    
}

extension TPNewTrainingViewController: TPTimePickerViewDelegate {
    public func tpTimePickerView(_ sender: TPTimePickerView, openStatusChanged isOpened: Bool) {
        handleContentSizeChange()
    }
    
    public func tpTimePickerView(_ sender: TPTimePickerView, selectedTimeChanged time: Date) {
        
    }
    
    public func tpTimePickerViewConstraintAndRelatedViewToAnimateHeightChange(_ sender: TPTimePickerView) -> (NSLayoutConstraint, UIView)? {
        return (trainingTimePickerHeightConstraint, rootScrollView)
    }
}

extension TPNewTrainingViewController: TPEmomSectionsListViewDelegate {
    public func tpEmomSectionsListViewItems(_ sender: TPEmomSectionsListView) -> [String] {
        return Array(repeating: "ОАp", count: 2)
    }
}
