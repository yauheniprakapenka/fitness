//
//  TPSectionHeaderView.swift
//  TrainingProgramm
//
//  Created by Vitali on 9/5/20.
//

import UIKit

public enum TPTrainingType {
    case emom
    case amrap
    case forTime
    case rest
}

public protocol TPSectionHeaderViewDelegate: class {
    func tpSectionHeaderView(_ sender: TPSectionHeaderView, selectTrainingType: TPTrainingType, userData: [AnyHashable: Any]?)
    func tpSectionHeaderView(_ sender: TPSectionHeaderView, selectTime: Int, userData: [AnyHashable: Any]?)
    func tpSectionHeaderView(_ sender: TPSectionHeaderView, inputName: String?, userData: [AnyHashable: Any]?)
}

@IBDesignable
public class TPSectionHeaderView: UIView {
    // MARK: - Views
    @IBOutlet private weak var trainingTypeView: TPTrainingTypeView!
    @IBOutlet private weak var nameInputView: TPTextInputView!
    @IBOutlet private weak var timeSelectionView: TPTimeSelectionView!
    
    // MARK: - Properties
    public weak var viewDelegate: TPSectionHeaderViewDelegate?
    
    public var userData: [AnyHashable: Any]?
    
    public var timeArray: [Int] = [
        1, 2, 5, 10, 16, 20
    ] {
        didSet {
            timeSelectionView.refreshData()
        }
    }
    
    public var name: String? {
        get {
            return nameInputView.text
        }
        set {
            nameInputView.text = newValue
        }
    }
    
    public func select(time: Int) {
        if let index = timeArray.firstIndex(of: time) {
            timeSelectionView.select(at: index)
        }
    }
    public func select(trainingType: TPTrainingType) {
        let mappedTrainingType: TPTrainingTypeView.TrainingType = {
            switch trainingType {
            case .emom: return .emom
            case .amrap: return .amrap
            case .forTime: return .forTime
            case .rest: return .rest
            }
        }()
        trainingTypeView.select(trainingType: mappedTrainingType)
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
        let view = loadFromNib()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        view.constraintAllSidesToSuperview()
        timeSelectionView.viewDelegate = self
        timeSelectionView.refreshData()
        trainingTypeView.viewDelegate = self
        nameInputView.viewDelegate = self
    }
}

// MARK: - TPTrainingTypeViewDelegate
extension TPSectionHeaderView: TPTrainingTypeViewDelegate {
    public func tpTrainingTypeView(sender: TPTrainingTypeView, didSelectTrainingType trainingType: TPTrainingTypeView.TrainingType) {
        let resultTraining: TPTrainingType = {
            switch trainingType {
            case .amrap: return .amrap
            case .emom: return .emom
            case .forTime: return .forTime
            case .rest: return .rest
            }
        }()
        viewDelegate?.tpSectionHeaderView(self, selectTrainingType: resultTraining, userData: userData)
    }
}

// MARK: - TPTextInputViewDelegate
extension TPSectionHeaderView: TPTextInputViewDelegate {
    public func tpTextInputViewShouldReturn(_ sender: TPTextInputView) -> Bool {
        return true
    }
    
    public func tpTextInputViewDidBeginEditing(_ sender: TPTextInputView) {}
    
    public func tpTextInputViewDidEndEditing(_ sender: TPTextInputView, byReturn: Bool) {
    }
    
    public func tpTextInputViewTextChanged(_ sender: TPTextInputView, changedText: String?) {
        viewDelegate?.tpSectionHeaderView(self, inputName: nameInputView.text, userData: userData)
    }
}

// MARK: - TPTimeSelectionViewDelegate
extension TPSectionHeaderView: TPTimeSelectionViewDelegate {
    public func tpTimeSelectionViewItems(_ sender: TPTimeSelectionView) -> [String] {
        return timeArray.map({ String($0) })
    }
    
    public func tpTimeSelectionView(_ sender: TPTimeSelectionView, didSelectItemAtIndex index: Int) {
        viewDelegate?.tpSectionHeaderView(self, selectTime: timeArray[index], userData: userData)
    }
}
