//
//  ExerciseItemContentView.swift
//  TrainingProgramm
//
//  Created by Vitali on 8/30/20.
//

// swiftlint:disable function_body_length

import UIKit
import CommonViews

public protocol TPExerciseItemContentViewDelegate: class {
    func tpExerciseItemContentView(_ sender: TPExerciseItemContentView, checkboxStatusChanged status: Bool, userData: [AnyHashable: Any]?)
    func tpExerciseItemContentViewPreviewTapped(_ sender: TPExerciseItemContentView, userData: [AnyHashable: Any]?)
}

private extension TPExerciseItemContentView {
    enum Const {
        static let cornerRadius: CGFloat = 8
        static let additionalBottomInsetWhenBottomContainerNotVisible: CGFloat = 15
        static let activeBakground = Asset.TrainingProgramm.ExerciseView.Colors.trainingProgrammExerciseViewActiveItemBackground.color
        static let mainTitleAndDescriptionUnselectedTextColor = Asset.TrainingProgramm.ExerciseView.Colors.trainingProgrammExerciseViewBlackText.color
        static let descriptionTextUnselectedTextColor = Asset.TrainingProgramm.ExerciseView.Colors.trainingProgrammExerciseViewGrayText.color
        static let activeItemTextColor = UIColor.white
        static let completedItemTextColor = Asset.TrainingProgramm.ExerciseView.Colors.trainingProgrammExerciseViewGrayText.color
    }
}

public extension TPExerciseItemContentView {
    enum ViewModel {
        case topContent(
                topTitle: String?,
                mainTitle: String?,
                checkboxStatus: Bool = false
             )
        case withBottomContentOnlyLeftSubitem(
                topTitle: String?,
                mainTitle: String?,
                leftSubtitle: String?,
                letfDescription: String?,
                videoPreviewImage: UIImage?,
                checkboxStatus: Bool = false
             )
        case fullContent(
                topTitle: String?,
                mainTitle: String?,
                leftSubtitle: String?,
                letfDescription: String?,
                rightSubtitle: String?,
                rightDescription: String?,
                videoPreviewImage: UIImage?,
                checkboxStatus: Bool = false
             )
    }
    
    enum State {
        case normal
        case active
        case completed
    }
}

@IBDesignable
public class TPExerciseItemContentView: UIViewExtended {
    // MARK: - Views
    private weak var contentView: UIViewExtended!
    @IBOutlet private weak var topTitleLabel: UILabel!
    @IBOutlet private weak var mainTitleLabel: UILabel!
    @IBOutlet private weak var checkboxView: TPCheckboxView!
    @IBOutlet private weak var bottomContainerView: UIView!
    @IBOutlet private weak var leftSubitemTitleLabel: UILabel!
    @IBOutlet private weak var leftSubitemDescriptionLabel: UILabel!
    @IBOutlet private weak var rightSubitemTitleLabel: UILabel!
    @IBOutlet private weak var rightSubitemDescriptionLabel: UILabel!
    @IBOutlet private weak var videoPreviewView: TPVideoPreviewView!
    
    // MARK: - Constraints
    @IBOutlet private weak var bottomContrainerViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    private var userData: [AnyHashable: Any]?
    public weak var viewDelegate: TPExerciseItemContentViewDelegate?
    
    private var storyboardBackgroundColor: UIColor = .white
    public var state: State = .normal {
        didSet {
            configureState()
        }
    }
    public var isCheckboxHidden: Bool = false {
        didSet {
            checkboxView.isHidden = isCheckboxHidden
        }
    }
    
    public override var backgroundColor: UIColor? {
        didSet {
            contentView?.backgroundColor = backgroundColor
            super.backgroundColor = UIColor.clear
        }
    }
    
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
        let contentView = loadFromNib()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.constraintAllSidesToSuperview()
        self.contentView = (contentView as! UIViewExtended)
        videoPreviewView.viewDelegate = self
        checkboxView.viewDelegate = self
        backgroundColor = .clear
        self.contentView.cornerRadius = Const.cornerRadius
        self.storyboardBackgroundColor = contentView.backgroundColor ?? UIColor.white
        configureState()
    }
    
    // MARK: - Main Interface
    public func configure(with model: ViewModel, userData: [AnyHashable: Any]?) {
        self.userData = userData
        switch model {
        case .topContent(topTitle: let topTitle,
                         mainTitle: let mainTitle,
                         checkboxStatus: let checkboxStatus):
            bottomContrainerViewHeightConstraint.constant = Const.additionalBottomInsetWhenBottomContainerNotVisible
            bottomContainerView.isHidden = true
            topTitleLabel.text = topTitle
            mainTitleLabel.text = mainTitle
            checkboxView.isChecked = checkboxStatus
        
        case .withBottomContentOnlyLeftSubitem(topTitle: let topTitle,
                                               mainTitle: let mainTitle,
                                               leftSubtitle: let leftSubtitle,
                                               letfDescription: let leftDescription,
                                               videoPreviewImage: let videoPreviewImage,
                                               checkboxStatus: let checkboxStatus):
            topTitleLabel.text = topTitle
            mainTitleLabel.text = mainTitle
            checkboxView.isChecked = checkboxStatus
            leftSubitemTitleLabel.text = leftSubtitle
            leftSubitemDescriptionLabel.text = leftDescription
            videoPreviewView.image = videoPreviewImage
            videoPreviewView.isHidden = videoPreviewImage == nil
            bottomContrainerViewHeightConstraint.constant = bottomContainerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            bottomContainerView.isHidden = false
            for view in [rightSubitemTitleLabel, rightSubitemDescriptionLabel] {
                view?.isHidden = true
            }
        case .fullContent(topTitle: let topTitle,
                          mainTitle: let mainTitle,
                          leftSubtitle: let leftSubtitle,
                          letfDescription: let leftDescription,
                          rightSubtitle: let rightSubtitle,
                          rightDescription: let rightDescription,
                          videoPreviewImage: let previewImage,
                          checkboxStatus: let checkboxStatus):
            topTitleLabel.text = topTitle
            mainTitleLabel.text = mainTitle
            checkboxView.isChecked = checkboxStatus
            leftSubitemTitleLabel.text = leftSubtitle
            leftSubitemDescriptionLabel.text = leftDescription
            rightSubitemTitleLabel.text = rightSubtitle
            rightSubitemDescriptionLabel.text = rightDescription
            videoPreviewView.image = previewImage
            videoPreviewView.isHidden = previewImage == nil
            bottomContrainerViewHeightConstraint.constant = bottomContainerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            bottomContainerView.isHidden = false
            for view in [rightSubitemTitleLabel, rightSubitemDescriptionLabel] {
                view?.isHidden = false
            }
        }
    }
}

private extension TPExerciseItemContentView {
    func configureState() {
        switch state {
        case .normal:
            contentView.backgroundColor = storyboardBackgroundColor
            mainTitleLabel.textColor = Const.mainTitleAndDescriptionUnselectedTextColor
            topTitleLabel.textColor = Const.descriptionTextUnselectedTextColor
            leftSubitemTitleLabel.textColor = Const.descriptionTextUnselectedTextColor
            rightSubitemTitleLabel.textColor = Const.descriptionTextUnselectedTextColor
            leftSubitemDescriptionLabel.textColor = Const.mainTitleAndDescriptionUnselectedTextColor
            rightSubitemDescriptionLabel.textColor = Const.mainTitleAndDescriptionUnselectedTextColor
        case .active:
            contentView.backgroundColor = Const.activeBakground
            for label in [mainTitleLabel, topTitleLabel, leftSubitemTitleLabel, leftSubitemDescriptionLabel, rightSubitemTitleLabel, rightSubitemDescriptionLabel] {
                label?.textColor = Const.activeItemTextColor
            }
        case .completed:
            contentView.backgroundColor = storyboardBackgroundColor
            for label in [mainTitleLabel, topTitleLabel, leftSubitemTitleLabel, leftSubitemDescriptionLabel, rightSubitemTitleLabel, rightSubitemDescriptionLabel] {
                label?.textColor = Const.completedItemTextColor
            }
        }
    }
}

// MARK: - CheckboxViewDelegate
extension TPExerciseItemContentView: TPCheckboxViewDelegate {
    public func tpCheckboxView(_ sender: TPCheckboxView, statusChangedTo checked: Bool) {
        viewDelegate?.tpExerciseItemContentView(self, checkboxStatusChanged: checked, userData: userData)
    }
}

// MARK: - VideoPreviewViewDelegate
extension TPExerciseItemContentView: TPVideoPreviewViewDelegate {
    public func tpVideoPreviewViewDidTap(_ sender: TPVideoPreviewView) {
        viewDelegate?.tpExerciseItemContentViewPreviewTapped(self, userData: userData)
    }
}
