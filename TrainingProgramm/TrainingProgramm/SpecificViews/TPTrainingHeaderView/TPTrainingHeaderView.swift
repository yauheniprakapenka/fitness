//
//  TPTrainingHeaderView.swift
//  TrainingProgramm
//
//  Created by Vitali on 9/6/20.
//

import UIKit
import CommonViews

public protocol TPTrainingHeaderViewDelegate: class {
    func tpTrainingHeaderView(_ sender: TPTrainingHeaderView, nameChanged newName: String?)
    func tpTrainingHeaderView(_ sender: TPTrainingHeaderView, descriptionChanged newDescription: String?)
    func tpTrainingHeaderView(_ sender: TPTrainingHeaderView, timeChanged newTime: Date?)
    func tpTrainingHeaderViewWillNeedAnimateHeightChange(_ sender: TPTrainingHeaderView, heightDelta: CGFloat, animationDuration: TimeInterval)
}

private extension TPTrainingHeaderView {
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

@IBDesignable
public class TPTrainingHeaderView: UIView {
    // MARK: - Views
    private weak var nameTextInputView: TPTextInputView!
    private weak var descriptionTextInputView: TPTextInputView!
    private weak var timePickerView: TPTimePickerView!
    
    // MARK: - Constraints
    public weak var trainingTimePickerHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    public weak var viewDelegate: TPTrainingHeaderViewDelegate?
    
    // MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initCommon()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initCommon()
    }
    
    private func initCommon() {
        translatesAutoresizingMaskIntoConstraints = false
        createContentViews(addTo: self)
        timePickerView.viewDelegate = self
        nameTextInputView.viewDelegate = self
        descriptionTextInputView.viewDelegate = self
        clipsToBounds = true
    }
    
}

// MARK: - Private methods
private extension TPTrainingHeaderView {
    func createContentViews(addTo superview: UIView) {
        let nameLabel = TPFormControllerUtils.createTitleLabel(
            superview: superview,
            text: "Название тренировки",
            topAnchor: superview.topAnchor,
            topOffet: Const.offsetTopTitleFirst)
        nameLabel.setContentHuggingPriority(.init(1000), for: .vertical)
        nameTextInputView = TPFormControllerUtils.createInputField(
            superview: superview,
            placeholderText: "Введите название",
            topAnchor: nameLabel.bottomAnchor,
            topOffset: Const.offsetTopInputFields)
        nameTextInputView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        let descriptionTitle = TPFormControllerUtils.createTitleLabel(
            superview: superview,
            text: "Описание",
            topAnchor: nameTextInputView.bottomAnchor,
            topOffet: Const.offsetTopTitleOthers)
        descriptionTitle.setContentHuggingPriority(.init(1000), for: .vertical)
        descriptionTextInputView = TPFormControllerUtils.createInputField(
            superview: superview,
            placeholderText: "Введите описание",
            topAnchor: descriptionTitle.bottomAnchor,
            topOffset: Const.offsetTopInputFields)
        descriptionTextInputView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        let startTimeLabel = TPFormControllerUtils.createTitleLabel(
            superview: superview,
            text: "Время начала",
            topAnchor: descriptionTextInputView.bottomAnchor,
            topOffet: Const.offsetTopTitleOthers)
        startTimeLabel.setContentHuggingPriority(.init(1000), for: .vertical)
        (timePickerView, trainingTimePickerHeightConstraint) = createTimePicker(superview: superview, topAnchor: startTimeLabel.bottomAnchor)
        timePickerView.setContentHuggingPriority(.init(rawValue: 249), for: .vertical)
        timePickerView.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
    }
    
    func createTimePicker(superview: UIView, topAnchor: NSLayoutYAxisAnchor) -> (TPTimePickerView, NSLayoutConstraint) {
        let picker = TPTimePickerView()
        superview.addSubview(picker)
        picker.timeViewLeftConstraint.constant = 0
        TPFormControllerUtils.makeConstraints(to: picker, topAnchor: topAnchor, topOffset: Const.offsetTopInputFields)
        let heightConstraint = picker.heightAnchor.constraint(equalToConstant: 55)
        heightConstraint.isActive = false
        return (picker, heightConstraint)
    }
}

// MARK: - TPTimePickerViewDelegate
extension TPTrainingHeaderView: TPTimePickerViewDelegate {
    public func tpTimePickerViewWillBegintAnimate(_ sender: TPTimePickerView, heightDelta: CGFloat, animationDuration: TimeInterval) {
        viewDelegate?.tpTrainingHeaderViewWillNeedAnimateHeightChange(self, heightDelta: heightDelta, animationDuration: animationDuration)
    }
    
    public func tpTimePickerView(_ sender: TPTimePickerView, openStatusChanged isOpened: Bool) {}
    
    public func tpTimePickerView(_ sender: TPTimePickerView, selectedTimeChanged time: Date) {
        viewDelegate?.tpTrainingHeaderView(self, timeChanged: time)
    }
}

extension TPTrainingHeaderView: TPTextInputViewDelegate {
    public func tpTextInputViewShouldReturn(_ sender: TPTextInputView) -> Bool {
        return true
    }
    
    public func tpTextInputViewDidBeginEditing(_ sender: TPTextInputView) {}
    
    public func tpTextInputViewDidEndEditing(_ sender: TPTextInputView, byReturn: Bool) {
        switch sender {
        case nameTextInputView:
            viewDelegate?.tpTrainingHeaderView(self, nameChanged: sender.text)
        case descriptionTextInputView:
            viewDelegate?.tpTrainingHeaderView(self, descriptionChanged: sender.text)
        default:
            fatalError()
        }
    }
    
    public func tpTextInputViewTextChanged(_ sender: TPTextInputView, changedText: String?) {}
}
