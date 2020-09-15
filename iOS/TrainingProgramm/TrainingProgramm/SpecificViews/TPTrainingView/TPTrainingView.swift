//
//  TPTrainingView.swift
//  TrainingProgramm
//
//  Created by Vitali on 9/6/20.
//

import UIKit

private extension TPTrainingView {
    enum Const {
        static let textAddMinute = "Добавить минуту"
        static let textAddExercise = "Добавить упражнение"
        static func textMinute(n: Int) -> String { return "Mинута \(n)" }
        static func textExercise(n: Int) -> String { return "Упражнение \(n)" }
    }
}

public protocol TPTrainingViewDelegate: class {
    func tpTrainingViewTrainingChanged(_ sender: TPTrainingView, training: TPTraining)
    func tpTrainingViewAddSectionVisibilityChange(_ sender: TPTrainingView, isVisible: Bool)
}

public class TPTrainingView: UITableView {
    public var trainingSections: [TPTrainingSection] = []
    
    private var heightTrainingSection: CGFloat = 0
    
    public private(set) var training: TPTraining!
    
    public weak var viewDelegate: TPTrainingViewDelegate?
    
    private weak var headerHeightConstraint: NSLayoutConstraint!
    private var exercises: [TPExercise] = []
    private var isAddSecionRowVisible: Bool = true
    
    // MARK: - Init
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        initCommon()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initCommon()
    }
    
    private func initCommon() {
        training = TPTraining()
        trainingSections = training.sections ?? []
        
        let header = TPTrainingHeaderView()
        header.viewDelegate = self
        header.layer.zPosition = -1
        tableHeaderView = header
        headerHeightConstraint = header.heightAnchor.constraint(equalToConstant: 342)
        headerHeightConstraint.isActive = true
        header.layoutIfNeeded()
        
        tableFooterView = UIView()
        register(TPTrainingViewAddSectionItemView.self, forCellReuseIdentifier: TPTrainingViewAddSectionItemView.description())
        register(TPTrainingViewAddSectionItemCell.self, forCellReuseIdentifier: TPTrainingViewAddSectionItemCell.description())
        register(TPTrainingSectionItemCell.self, forCellReuseIdentifier: TPTrainingSectionItemCell.description())
        rowHeight = UITableView.automaticDimension
        dataSource = self
        delegate = self
        clipsToBounds = true
    }
    
    // MARK: - Main Interface
    public func configure(withTraining training: TPTraining) {
        self.training = training
        trainingSections = training.sections ?? []
        reloadData()
    }
    
    public func configure(withAllowedExercises exercises: [TPExercise]) {
        self.exercises = exercises
        reloadData()
    }
    
    public func refreshData() {
        reloadData()
    }
    
    public func addSection() {
        trainingSections.append(.emom(minutes: 1, items: [], name: nil))
        notifyTrainingChanged()
        reloadData()
    }
}

// MARK: - Private Methods
private extension TPTrainingView {
    func notifyTrainingChanged() {
        let training = TPTraining()
        training.name = self.training.name
        training.descriptionText = self.training.descriptionText
        training.time = self.training.time
        training.sections = trainingSections
        viewDelegate?.tpTrainingViewTrainingChanged(self, training: training)
    }
}

// MARK: - UITableViewDataSource
extension TPTrainingView: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        let addSection = 1
        return addSection + trainingSections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let trainingSectionIdx = section - 1
        switch section {
        case 0:
            return 1
        default:
            let trainingSection = trainingSections[trainingSectionIdx]
            if let items = trainingSection.items {
                return items.count + 1
            } else {
                return 0
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard
                let cell = dequeueReusableCell(withIdentifier: TPTrainingViewAddSectionItemView.description()) as? TPTrainingViewAddSectionItemView else {
                return UITableViewCell()
            }
            cell.cellContentView.viewDelegate = self
            return cell
        default:
            let row = indexPath.row
            let trainingSectionsIdx = indexPath.section - 1
            let trainingSection = trainingSections[trainingSectionsIdx]
            var isAddRow = false
            if let items = trainingSection.items {
                isAddRow = items.isEmpty || row == items.count
            }
            if isAddRow {
                let cell = dequeueReusableCell(withIdentifier: TPTrainingViewAddSectionItemCell.description(), for: indexPath) as? TPTrainingViewAddSectionItemCell
                let title: String = {
                    switch trainingSection.trainingType {
                    case .emom:
                        return Const.textAddMinute
                    case .amrap, .forTime:
                        return Const.textAddExercise
                    default:
                        return ""
                    }
                }()
                cell?.configure(withTitle: title, viewDelegate: self, userData: ["TrainingSectionIndex": trainingSectionsIdx])
                return cell ?? UITableViewCell()
            } else {
                guard
                    let item = trainingSection.items?[row],
                    let cell = dequeueReusableCell(withIdentifier: TPTrainingSectionItemCell.description(), for: indexPath) as? TPTrainingSectionItemCell
                else {
                    return UITableViewCell()
                }
                let title: String = {
                    switch trainingSection {
                    case .emom:
                        return Const.textMinute(n: row + 1)
                    case .amrap, .forTime:
                        return Const.textExercise(n: row + 1)
                    default:
                        return ""
                    }
                }()
                
                let userData = [
                    "TrainingSectionIndex": trainingSectionsIdx,
                    "ItemIndex": row
                ]
                cell.configure(withTitle: title,
                               sectionItem: item,
                               exercises: exercises,
                               viewDelegate: self,
                               userData: userData)
                return cell
                
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension TPTrainingView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let trainingSectionsIdx = section - 1
        switch section {
        case 0:
            return UIView()
        default:
            let view = TPSectionHeaderView()
            view.viewDelegate = self
            view.userData = [
                "TrainingSectionIndex": trainingSectionsIdx,
                "TableSectionIndex": section
            ]
            let item = trainingSections[trainingSectionsIdx]
            view.select(time: item.minutes)
            view.select(trainingType: item.trainingType)
            view.name = trainingSections[trainingSectionsIdx].name
            return view
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return TPSectionHeaderView().systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        }
    }
}

extension TPTrainingView: TPSectionHeaderViewDelegate {
    public func tpSectionHeaderView(_ sender: TPSectionHeaderView, selectTrainingType: TPTrainingType, userData: [AnyHashable : Any]?) {
        guard
            let index = userData?["TrainingSectionIndex"] as? Int,
            let tableSection = userData?["TableSectionIndex"] as? Int
        else { fatalError() }
        
        guard trainingSections[index].trainingType != selectTrainingType else { return }
        
        let minutes = trainingSections[index].minutes
        let name = trainingSections[index].name
        
        switch selectTrainingType {
        case .emom:
            trainingSections[index] = .emom(minutes: minutes, items: [], name: name)
        case .amrap:
            trainingSections[index] = .amrap(minutes: minutes, items: [], name: name)
        case .forTime:
            trainingSections[index] = .forTime(minutes: minutes, items: [], name: name)
        case .rest:
            trainingSections[index] = .rest(minutes: minutes, name: name)
        }
        notifyTrainingChanged()
        let reloadSection = IndexSet(integer: tableSection)
        beginUpdates()
        deleteSections(reloadSection, with: .fade)
        insertSections(reloadSection, with: .fade)
        endUpdates()
    }
    
    public func tpSectionHeaderView(_ sender: TPSectionHeaderView, selectTime: Int, userData: [AnyHashable : Any]?) {
        guard
            let index = userData?["TrainingSectionIndex"] as? Int
        else { fatalError() }
        trainingSections[index] = trainingSections[index].withChangedTime(newMinutes: selectTime)
        notifyTrainingChanged()
    }
    
    public func tpSectionHeaderView(_ sender: TPSectionHeaderView, inputName: String?, userData: [AnyHashable : Any]?) {
        guard
            let index = userData?["TrainingSectionIndex"] as? Int
        else { fatalError() }
        trainingSections[index] = trainingSections[index].withChangedName(newName: inputName)
        notifyTrainingChanged()
    }
    
}

// MARK: - TPTrainingAddEntityViewDelegate
extension TPTrainingView: TPTrainingAddEntityViewDelegate {
    public func tpTrainingAddEntityViewButtonDidTap(_ sender: TPTrainingAddEntityView, userData: [AnyHashable : Any]?) {
        
        if let trainintSectionIndex = userData?["TrainingSectionIndex"] as? Int {
            trainingSections[trainintSectionIndex] = trainingSections[trainintSectionIndex].addedEmptyItem()
            notifyTrainingChanged()
            let reloadSection = IndexSet(integer: trainintSectionIndex + 1)
            beginUpdates()
            deleteSections(reloadSection, with: .fade)
            insertSections(reloadSection, with: .fade)
            endUpdates()
            return
        }
        
        trainingSections.append(.emom(minutes: 1, items: [], name: nil))
        notifyTrainingChanged()
        reloadData()

    }
}

extension TPTrainingView: TPTrainingSectionItemContentViewDelegate {
    public func tpTrainingSectionItemContentView(
        _ sender: TPTrainingSectionItemContentView,
        modelUpdated model: TPTrainingSectionItem,
        emptyFields: [TPTrainingSectionItemContentView.Field],
        notValidFields: [TPTrainingSectionItemContentView.Field],
        userData: [AnyHashable : Any]?) {
        
        guard
            let trainingSectionIndex = userData?["TrainingSectionIndex"] as? Int,
            let itemIndex = userData?["ItemIndex"] as? Int
        else {
            fatalError()
        }
        guard var exercises = trainingSections[trainingSectionIndex].items else {
            fatalError()
        }
        exercises[itemIndex] = model
        trainingSections[trainingSectionIndex] = trainingSections[trainingSectionIndex].changeItems(exercises)
        notifyTrainingChanged()
    }
    
    public func tpTrainingSectionItemContentWillNeedAnimateHeightChange(_ sender: TPTrainingSectionItemContentView, heightDelta: CGFloat, animationDuration: TimeInterval, userData: [AnyHashable: Any]?) {
        
    }
}

extension TPTrainingView: TPTrainingHeaderViewDelegate {
    public func tpTrainingHeaderViewWillNeedAnimateHeightChange(_ sender: TPTrainingHeaderView, heightDelta: CGFloat, animationDuration: TimeInterval) {
        
        UIView.animate(withDuration: animationDuration, animations: {
            self.headerHeightConstraint.constant += heightDelta
            self.tableHeaderView?.layoutIfNeeded()
            self.reloadData()
        })
    }
    
    public func tpTrainingHeaderView(_ sender: TPTrainingHeaderView, nameChanged newName: String?) {
        training.name = newName
        notifyTrainingChanged()
    }
    
    public func tpTrainingHeaderView(_ sender: TPTrainingHeaderView, descriptionChanged newDescription: String?) {
        training.descriptionText = newDescription
        notifyTrainingChanged()
    }
    
    public func tpTrainingHeaderView(_ sender: TPTrainingHeaderView, timeChanged newTime: Date?) {
        training.time = newTime
        notifyTrainingChanged()
    }
}

extension TPTrainingView: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var addSectionVisible = false
        for indexPath in indexPathsForVisibleRows ?? [] {
            if indexPath.section == 0 && indexPath.row == 0 {
                addSectionVisible = true
            }
        }
        if addSectionVisible != isAddSecionRowVisible {
            isAddSecionRowVisible = addSectionVisible
            viewDelegate?.tpTrainingViewAddSectionVisibilityChange(self, isVisible: isAddSecionRowVisible)
        }
    }
}

private extension TPTrainingSection {
    func isSameKind(of trainingSection: TPTrainingSection) -> Bool {
        switch (self, trainingSection) {
        case (.amrap, .amrap):
            return true
        case (.emom, .emom):
            return true
        case (.forTime, .forTime):
            return true
        case (.rest, .rest):
            return true
        default:
            return false
        }
    }
    
    func addedEmptyItem() -> Self {
        switch self {
        case .amrap(minutes: let minutes, items: let items, name: let name):
            return .amrap(minutes: minutes, items: items + [TPTrainingSectionItem()], name: name)
        case .emom(minutes: let minutes, items: let items, name: let name):
            return .emom(minutes: minutes, items: items + [TPTrainingSectionItem()], name: name)
        case .forTime(minutes: let minutes, items: let items, name: let name):
            return .forTime(minutes: minutes, items: items + [TPTrainingSectionItem()], name: name)
        case .rest(minutes: let minutes, name: let name):
            return .rest(minutes: minutes, name: name)
        }
    }
    
    func changeItems(_ newItems: [TPTrainingSectionItem]) -> Self {
        switch self {
        case .amrap(minutes: let minutes, items: _, name: let name):
            return .amrap(minutes: minutes, items: newItems, name: name)
        case .emom(minutes: let minutes, items: _, name: let name):
            return .emom(minutes: minutes, items: newItems, name: name)
        case .forTime(minutes: let minutes, items: _, name: let name):
            return .forTime(minutes: minutes, items: newItems, name: name)
        case .rest(minutes: let minutes, name: let name):
            return .rest(minutes: minutes, name: name)
        }
    }
}
