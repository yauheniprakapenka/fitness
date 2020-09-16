//
//  TrainingDescriptionView.swift
//  TrainingProgramm
//
//  Created by Vitali on 9/16/20.
//

import UIKit


public extension TrainingDescriptionView {
    struct ItemViewModel {
        public enum ItemState {
            case normal
            case active
            case completed
        }
        
        var itemState: ItemState
        var isCheckboxVisible: Bool
        var contentViewModel: TPExerciseItemContentView.ViewModel
        
        public init(isCheckboxVisible: Bool,
                    itemState: ItemState,
                    contentViewModel: TPExerciseItemContentView.ViewModel) {
            self.isCheckboxVisible = isCheckboxVisible
            self.itemState = itemState
            self.contentViewModel = contentViewModel
        }
    }
}

public class TrainingDescriptionView: UITableView {
    
    var training: TPTraining = TPTraining()
    var exercises: [TPExercise] = []
    
    weak var header: TrainingDescriptionHeaderView?
    
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
        let header = TrainingDescriptionHeaderView()
        self.header = header
        let headerSize = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        header.frame = CGRect(origin: .zero, size: CGSize(width: headerSize.width, height: headerSize.height + 50))
        tableHeaderView = header
        separatorStyle = .none
        tableFooterView = UIView()
        rowHeight = UITableView.automaticDimension
        register(TrainingDescriptionSectionItemView.self, forCellReuseIdentifier: TrainingDescriptionSectionItemView.description())
        clipsToBounds = true
        dataSource = self
        delegate = self
        allowsSelection = false
        showsVerticalScrollIndicator = false
    }
    
    // MARK: - Main Interface
    public func configure(with training: TPTraining) {
        self.training = training
        header?.nameLabel.text = training.name
        header?.descriptionLabel.text = training.descriptionText
        reloadData()
    }
    public func refreshData() {
        reloadData()
    }
}

extension TrainingDescriptionView: TPExerciseItemContentViewDelegate {
    public func tpExerciseItemContentView(_ sender: TPExerciseItemContentView, checkboxStatusChanged status: Bool, userData: [AnyHashable : Any]?) {
        
    }
    
    public func tpExerciseItemContentViewPreviewTapped(_ sender: TPExerciseItemContentView, userData: [AnyHashable : Any]?) {
        
    }
}

extension TrainingDescriptionView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let section = training.sections?[section] else {
            return nil
        }
        let sectionView = TrainingDescriptionSectionHeaderView()
        sectionView.nameLabel.text = section.name
        sectionView.typeLabel.text = section.trainingType.title
        return sectionView
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
}

extension TrainingDescriptionView: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return training.sections?.count ?? 0
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = training.sections else {
            return 0
        }
        return sections[section].items?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let item = training.sections?[indexPath.section].items?[indexPath.row],
            let itemExercise = exercises.first(where: { $0.id == item.exerciseId })
        else {
            return UITableViewCell()
        }
        guard let cell = dequeueReusableCell(withIdentifier: TrainingDescriptionSectionItemView.description(), for: indexPath) as? TrainingDescriptionSectionItemView else {
            return UITableViewCell()
        }
        
        
        let model = ItemViewModel(
            isCheckboxVisible: true,
            itemState: .normal,
            contentViewModel: .fullContent(
                topTitle: "Упражнение 1",
                mainTitle: itemExercise.name ?? "Без имени",
                leftSubtitle: item.profileValue ?? "",
                letfDescription: "\(item.defaultForMan ?? 0)",
                rightSubtitle: "Повторы",
                rightDescription: "\(item.repeats ?? 2)",
                videoPreviewImage: UIImage(),
                checkboxStatus: false))
        
        
        let userData: [AnyHashable: Any] = [
            "Row": indexPath.row,
            "Section": indexPath.section
        ]
        
        cell.configire(with: model, delegate: self, userData: userData)
        return cell
    }
}

private extension TPTrainingType {
    var title: String {
        switch self {
        case .amrap:
            return "AMRAP"
        case .emom:
            return "EMOM"
        case .forTime:
            return "FORTIME"
        case .rest:
            return "REST"
        }
    }
}
