//
//  SelectableItemView.swift
//  TrainingProgramm
//
//  Created by Vitali on 8/25/20.
//

import UIKit
import CommonViews

public extension SelectableItemView {
    struct Appearance {
        public var cornerRadius: CGFloat = 0
        public var selectedColor: UIColor = .gray
        public var unselectedColor: UIColor = .white
        public var selectedBorderColor: UIColor = .blue
        public var unselectedBorderColor: UIColor = .blue
        public var borderWidth: CGFloat = 0
        public var font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        public var selectedTextColor = UIColor.white
        public var unselectedTextColor = UIColor.gray
        public var edgeInsets = UIEdgeInsets.zero
        public var animationDuration = 0.3
    }
}

public protocol SelectableItemViewDelegate: class {
    func selectableItemViewShouldChangeSelection(sender: SelectableItemView) -> Bool
    func selectableItemView(sender: SelectableItemView, selectionChanged isSelected: Bool)
}

@IBDesignable
open class SelectableItemView: UIViewExtended {
    // MARK: - Views and Constraints
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var topConstraint: NSLayoutConstraint!
    @IBOutlet private weak var leftConstraint: NSLayoutConstraint!
    @IBOutlet private weak var rightConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    public var appearance = Appearance() {
        didSet {
            configureAppearance()
        }
    }
    public var isSelected: Bool = false {
        didSet {
            animateAppearance()
            setNeedsDisplay()
        }
    }
    
    public var text: String? {
        didSet {
            textLabel.text = text
        }
    }
    
    public weak var viewDelegate: SelectableItemViewDelegate?
    
    open override var intrinsicContentSize: CGSize {
        get {
            let textSize = textLabel.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
            return textSize.applying(insets: appearance.edgeInsets)
        }
    }
    
    // MARK: - Initialization
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initCommon()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initCommon()
    }
    
    private func initCommon() {
        let view = loadFromNib(type: SelectableItemView.self)
        addSubview(view)
        view.frame = bounds
        view.translatesAutoresizingMaskIntoConstraints = false
        view.constraintAllSidesToSuperview()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleViewTapped))
        view.addGestureRecognizer(gestureRecognizer)
        configureAppearance()
    }
    
    // MARK: - Actions and Action Callbacks
    @objc
    private func handleViewTapped() {
        if viewDelegate?.selectableItemViewShouldChangeSelection(sender: self) ?? false {
            isSelected = !isSelected
            viewDelegate?.selectableItemView(sender: self, selectionChanged: isSelected)
        }
    }
}

private extension SelectableItemView {
    func animateAppearance() {
        UIView.animate(withDuration: appearance.animationDuration) {
            self.configureAppearance()
        }
    }
    
    func configureAppearance() {
        borderColor = isSelected ? appearance.selectedBorderColor : appearance.unselectedBorderColor
        borderWidth = appearance.borderWidth
        backgroundColor = isSelected ? appearance.selectedColor : appearance.unselectedColor
        cornerRadius = appearance.cornerRadius
        textLabel.font = appearance.font
        textLabel.textColor = isSelected ? appearance.selectedTextColor : appearance.unselectedTextColor
        
        configureConstraints()
    }
    
    func configureConstraints() {
        topConstraint.constant = appearance.edgeInsets.top
        bottomConstraint.constant = appearance.edgeInsets.bottom
        leftConstraint.constant = appearance.edgeInsets.left
        rightConstraint.constant = appearance.edgeInsets.right
    }
}
