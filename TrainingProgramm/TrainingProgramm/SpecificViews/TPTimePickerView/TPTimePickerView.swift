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
        
        static let animDurationCloseSizeChange = 0.2
        static let animDurationClosedFade = 0.2
        static let animDurationCloseIcon = animDurationClosedFade + animDurationCloseSizeChange
        static let animDurationOpen = 0.4
        static let timePickerOpenedDefaultHeight: CGFloat = 144
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
            updateToCurrentState(animated: true)
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
    
    public var openedPickerAdditionalHeight: CGFloat = Const.timePickerOpenedDefaultHeight
    
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
        updateToCurrentState(animated: false)
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
    
    func updateFadeToCurrentState() {
        timePickerView.alpha = isOpened ? 1 : 0
    }
    
    func updateIconToCurrentState() {
        iconImageView.transform = isOpened ? CGAffineTransform(rotationAngle: CGFloat(Double.pi)) : CGAffineTransform.identity
    }
    
    func updateResizeToCurrentState() {
        guard let (constraint, view) = viewDelegate?.tpTimePickerViewConstraintAndRelatedViewToAnimateHeightChange(self) else {
            return
        }
        if isOpened {
            constraint.constant += openedPickerAdditionalHeight
        } else {
            constraint.constant -= openedPickerAdditionalHeight
        }
        view.layoutIfNeeded()
    }
    
    func updateToCurrentState(animated: Bool) {
        guard animated else {
            updateFadeToCurrentState()
            updateIconToCurrentState()
            updateResizeToCurrentState()
            return
        }
        
        if isOpened {
            UIView.animate(withDuration: Const.animDurationOpen) {
                self.updateFadeToCurrentState()
                self.updateResizeToCurrentState()
                self.updateIconToCurrentState()
            }
        } else {
            UIView.animate(withDuration: Const.animDurationClosedFade, animations: {
                self.updateFadeToCurrentState()
            }, completion: { _ in
                UIView.animate(withDuration: Const.animDurationCloseSizeChange) {
                    self.updateResizeToCurrentState()
                }
            })
            UIView.animate(withDuration: Const.animDurationCloseIcon) {
                self.updateIconToCurrentState()
            }
        }
    }
}
