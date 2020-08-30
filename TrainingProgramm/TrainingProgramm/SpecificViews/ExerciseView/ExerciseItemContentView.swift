//
//  ExerciseItemContentView.swift
//  TrainingProgramm
//
//  Created by Vitali on 8/30/20.
//

import UIKit

public protocol ExerciseItemContentViewDelegate: class {
    func exerciseItemContentView(_ sender: ExerciseItemContentView, checkboxStatusChanged status: Bool, userData: [AnyHashable: Any]?)
    func exerciseItemContentViewPreviewTapped(_ sender: ExerciseItemContentView, userData: [AnyHashable: Any]?)
}

public extension ExerciseItemContentView {
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
}

@IBDesignable
public class ExerciseItemContentView: UIView {
    // MARK: - Views
    @IBOutlet private weak var topTitleLabel: UILabel!
    @IBOutlet private weak var mainTitleLabel: UILabel!
    @IBOutlet private weak var checkboxView: CheckboxView!
    @IBOutlet private weak var bottomContainerView: UIView!
    @IBOutlet private weak var leftSubitemTitleLabel: UILabel!
    @IBOutlet private weak var leftSubitemDescriptionLabel: UILabel!
    @IBOutlet private weak var rightSubitemTitleLabel: UILabel!
    @IBOutlet private weak var rightSubitemDescriptionLabel: UILabel!
    @IBOutlet private weak var videoPreviewView: VideoPreviewView!
    
    // MARK: - Constraints
    @IBOutlet private weak var bottomContrainerViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    private var userData: [AnyHashable: Any]?
    public weak var viewDelegate: ExerciseItemContentViewDelegate?
    
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
        videoPreviewView.viewDelegate = self
        checkboxView.viewDelegate = self
    }
    
    // MARK: - Main Interface
    public func configure(with model: ViewModel, userData: [AnyHashable: Any]?) {
        self.userData = userData
        switch model {
        case .topContent(topTitle: let topTitle,
                         mainTitle: let mainTitle,
                         checkboxStatus: let checkboxStatus):
            bottomContrainerViewHeightConstraint.constant = 0
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
        }
    }
}

// MARK: - CheckboxViewDelegate
extension ExerciseItemContentView: CheckboxViewDelegate {
    public func checkboxView(_ sender: CheckboxView, statusChangedTo checked: Bool) {
        viewDelegate?.exerciseItemContentView(self, checkboxStatusChanged: checked, userData: userData)
    }
}

// MARK: - VideoPreviewViewDelegate
extension ExerciseItemContentView: VideoPreviewViewDelegate {
    public func videoPreviewViewDidTap(_ sender: VideoPreviewView) {
        viewDelegate?.exerciseItemContentViewPreviewTapped(self, userData: userData)
    }
}
