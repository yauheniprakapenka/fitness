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
    func tpTimePickerViewWillBegintAnimate(_ sender: TPTimePickerView, heightDelta: CGFloat, animationDuration: TimeInterval)
}

private extension TPTimePickerView {
    typealias OnAnimationFinishedCallback = () -> Void
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
            updateToCurrentState(animated: true) {
                self.viewDelegate?.tpTimePickerView(self, openStatusChanged: self.isOpened)
            }
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
        view.setContentHuggingPriority(.init(249), for: .vertical)
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
    }
    
    @objc
    private func handleTimePickerChange(sender: UIDatePicker) {
        updateTimeLabel()
        viewDelegate?.tpTimePickerView(self, selectedTimeChanged: timePickerView.date)
    }
    
    public override var intrinsicContentSize: CGSize {
        get {
            let inputSize = borderContainerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
            let height = inputSize.height + (isOpened ? openedPickerAdditionalHeight : 0)
            return CGSize(width: UIView.noIntrinsicMetric, height: height)
        }
    }
    
    public override func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
        return intrinsicContentSize
    }
}

// MARK: - Private Methods
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
    
    func updateResizeToCurrentState(duration: TimeInterval = 0.0) {
        let delta = isOpened ? openedPickerAdditionalHeight : -openedPickerAdditionalHeight
        viewDelegate?.tpTimePickerViewWillBegintAnimate(self, heightDelta: delta, animationDuration: Const.animDurationOpen)
    }
    
    func updateToCurrentState(animated: Bool, completion: OnAnimationFinishedCallback? = nil) {
        guard animated else {
            updateFadeToCurrentState()
            updateIconToCurrentState()
            updateResizeToCurrentState()
            completion?()
            return
        }
        
        if isOpened {
            self.updateResizeToCurrentState(duration: Const.animDurationOpen)
            UIView.animate(withDuration: Const.animDurationOpen, animations: {
                self.updateFadeToCurrentState()
                self.updateIconToCurrentState()
            }, completion: { _ in completion?() })
        } else {
            UIView.animate(withDuration: Const.animDurationClosedFade, animations: {
                self.updateFadeToCurrentState()
            }, completion: { _ in
                self.updateResizeToCurrentState(duration: Const.animDurationCloseSizeChange)
                completion?()
            })
            UIView.animate(withDuration: Const.animDurationCloseIcon) {
                self.updateIconToCurrentState()
            }
        }
    }
}
