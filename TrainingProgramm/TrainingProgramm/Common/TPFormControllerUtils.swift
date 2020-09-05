//
//  TPFormControllerUtils.swift
//  TrainingProgramm
//
//  Created by Vitali on 9/5/20.
//

import UIKit
import CommonViews

class TPFormControllerUtils {
    static let titleLabelDecoration: Decoration<UILabel> = { label in
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = Asset.TrainingProgramm.CommonColors.tpBlackText.color
    }
    static let offsetTopTitleFirst: CGFloat = 38
    static let offsetTopTitleOthers: CGFloat = 25
    static let offsetTopInputFields: CGFloat = 15
    static let offsetLeftRightAllFields: CGFloat = 25
    
    static func makeConstraints(to view: UIView, topAnchor: NSLayoutYAxisAnchor, topOffset: CGFloat, leftRight: CGFloat = offsetLeftRightAllFields) {
        guard let superview = view.superview else {
            fatalError("No superview")
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: topAnchor, constant: topOffset).isActive = true
        view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leftRight).isActive = true
        view.widthAnchor.constraint(equalTo: superview.widthAnchor, constant: -2 * leftRight).isActive = true
    }
    
    static func createRootScrollView(superview: UIView) -> UIScrollView {
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
    
    static func createTitleLabel(superview: UIView, text: String, topAnchor: NSLayoutYAxisAnchor, topOffet: CGFloat) -> UILabel {
        let label = UILabel()
        superview.addSubview(label)
        makeConstraints(to: label, topAnchor: topAnchor, topOffset: topOffet)
        label.text = text
        label.decorator.apply(titleLabelDecoration)
        return label
    }
    
    static func createInputField(superview: UIView, placeholderText: String, topAnchor: NSLayoutYAxisAnchor, topOffset: CGFloat) -> TPTextInputView {
        let input = TPTextInputView()
        superview.addSubview(input)
        makeConstraints(to: input, topAnchor: topAnchor, topOffset: topOffset)
        input.placeholderText = placeholderText
        return input
    }
}
