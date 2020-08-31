//
//  TPTimePickerView.swift
//  TrainingProgramm
//
//  Created by Vitali on 8/31/20.
//

import UIKit
import CommonViews

public protocol TPTimePickerViewDelegate: class {
    func tpTimePickerView(_ sender: TPTimePickerView, openStatusChanged isOpened: Bool)
    func tpTimePickerView(_ sender: TPTimePickerView, selectedTimeChanged time: Date)
    func tpTimePickerViewConstraintAndRelatedViewToAnimateHeightChange(_ sender: TPTimePickerView) -> (NSLayoutConstraint, UIView)?
}

private extension TPTimePickerView {
    enum Const {
        static let formatter: DateFormatter = {
           let fm = DateFormatter()
            fm.dateFormat = "HH:mm"
            return fm
        }()
        
        static let animDuration = 0.4
        static let timePickerOpenedHeight: CGFloat = 144
    }
}

@IBDesignable
public class TPTimePickerView: UIView {
    // MARK: - Views
    @IBOutlet private weak var borderContainerView: UIViewExtended!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var timePickerView: UIDatePicker!
    
    // MARK: - Constraints
    @IBOutlet public weak var timeViewRightConstraint: NSLayoutConstraint!
    @IBOutlet public weak var timeViewLeftConstraint: NSLayoutConstraint!
    @IBOutlet public weak var timeViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var timeViewBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    
    public weak var viewDelegate: TPTimePickerViewDelegate?
    public var isOpened: Bool = false {
        didSet {
            animateStateChange()
        }
    }
    public var currentDate: Date {
        get {
            return timePickerView.date
        }
        set {
            timePickerView.date = newValue
            updateTimeLabel()
        }
    }
    
    // MARK: - Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        inintCommon()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        inintCommon()
    }
    
    private func inintCommon() {
        let view = loadFromNib()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        view.constraintAllSidesToSuperview()
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTimeViewTap))
        borderContainerView.addGestureRecognizer(recognizer)
        timePickerView.addTarget(self, action: #selector(handleTimePickerChange(sender:)), for: .valueChanged)
        updateTimeLabel()
        updateViewsToCurrentState()
    }
    
    // MARK: - Actions and Action Callbacks
    @objc
    private func handleTimeViewTap() {
        isOpened = !isOpened
        viewDelegate?.tpTimePickerView(self, openStatusChanged: isOpened)
    }
    
    @objc
    private func handleTimePickerChange(sender: UIDatePicker) {
        updateTimeLabel()
        viewDelegate?.tpTimePickerView(self, selectedTimeChanged: timePickerView.date)
    }
}

private extension TPTimePickerView {
    func updateTimeLabel() {
        let timeString = Const.formatter.string(from: timePickerView.date)
        timeLabel.text = timeString
    }
    
    func updateViewsToCurrentState(additionalConstraint: NSLayoutConstraint? = nil, additionalView: UIView? = nil) {
        if isOpened {
            additionalConstraint?.constant += Const.timePickerOpenedHeight
        } else {
            additionalConstraint?.constant -= Const.timePickerOpenedHeight
        }
        additionalView?.layoutIfNeeded()
        timePickerView.alpha = isOpened ? 1 : 0
        iconImageView.transform = isOpened ? CGAffineTransform(rotationAngle: CGFloat(Double.pi)) : CGAffineTransform.identity
        //layoutIfNeeded()
    }
    
    func animateStateChange() {
        let constraintAndView = viewDelegate?.tpTimePickerViewConstraintAndRelatedViewToAnimateHeightChange(self)
        let view = constraintAndView?.1
        let constraint = constraintAndView?.0
        UIView.animate(withDuration: Const.animDuration) {
            self.updateViewsToCurrentState(additionalConstraint: constraint, additionalView: view)
        }
    }
}
