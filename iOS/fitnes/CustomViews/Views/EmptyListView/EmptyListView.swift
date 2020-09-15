//
//  MessageWithActionView.swift
//  fitnes
//
//  Created by Vitali on 9/10/20.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

extension EmptyListView {
    typealias OnActonButtonTappedHandler = () -> Void
}

@IBDesignable
class EmptyListView: UIView {
    // MARK: - Views
    private weak var messageLabel: UILabel!
    private weak var actionButton: UIButton!
    private weak var imageView: UIImageView!
    
    // MARK: - Properties
    public var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
        }
    }
    
    public var buttonTitle: String? {
        get {
            return actionButton.title(for: .normal)
        }
        set {
            actionButton.setTitle(newValue, for: .normal)
        }
    }
    
    public var buttonHidden: Bool {
        get {
            return actionButton.isHidden
        }
        set {
            actionButton.isHidden = newValue
        }
    }
    
    public var messageText: String? {
        get {
            return messageLabel.text
        }
        set {
            messageLabel.text = newValue
        }
    }
    
    public var messageColor: UIColor? {
        get {
            return messageLabel.textColor
        }
        set {
            messageLabel.textColor = newValue
        }
    }
    public var buttonTextColor: UIColor? {
        get {
            return actionButton.titleLabel?.textColor
        }
        set {
            actionButton.setTitleColor(newValue, for: .normal)
        }
    }
    
    public var onActionButtonTapped: OnActonButtonTappedHandler?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initCommon()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initCommon()
    }
    
    private func initCommon() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.shadowOffset = CGSize(width: 0, height: 4.0)
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 2.0
        
        imageView = createImageView(addTo: self)
        messageLabel = createLabel(addTo: self)
        actionButton = createButton(addTo: self, topAnchor: messageLabel.bottomAnchor, topOffset: 10)
    }
    
    // MARK: - Actions and Action callbacks
    @objc
    private func handleTap() {
        onActionButtonTapped?()
    }
}

private extension EmptyListView {
    func createLabel(addTo superview: UIView) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(label)
        label.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 50).isActive = true
        label.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -50).isActive = true
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -20).isActive = true
        label.alpha = 0.8
        label.textColor = #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1)
        label.backgroundColor = .white
        label.layer.cornerRadius = 3
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }
    
    func createImageView(addTo superview: UIView) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(imageView)
        imageView.constraintAllSidesToSuperview()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.alpha = 0.3
        return imageView
    }
    
    func createButton(addTo superview: UIView, topAnchor: NSLayoutYAxisAnchor, topOffset: CGFloat) -> UIButton {
        let button = UIButton()
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(button)
        button.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: topAnchor, constant: topOffset).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        return button
    }
}
