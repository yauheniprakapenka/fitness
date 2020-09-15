//
//  TPNewTrainingViewController.swift
//  TrainingProgramm
//
//  Created by Vitali on 9/5/20.
//

import UIKit
import CommonViews

public extension TPNewTrainingViewController {
    enum Mode {
        case creation
        case edit(training: TPTraining)
    }
}

public extension TPNewTrainingViewController {
    typealias OnSaveHandler = () -> Void
}

public class TPNewTrainingViewController: UIViewController {
    public static func instance() -> TPNewTrainingViewController {
        let storyboard = UIStoryboard(name: "TPNewTrainingViewController", bundle: TrainingProgrammModule.bundle)
        let controller = storyboard.instantiateViewController(identifier: "TPNewTrainingViewController") as! TPNewTrainingViewController
        return controller
    }
    
    @IBOutlet weak var listView: TPTrainingView!
    @IBOutlet weak var addSectionFloatingView: TPTrainingAddEntityView!
    @IBOutlet weak var addSectionFloatingViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var floatingViewContainerView: UIView!
    
    // MARK: - Properties
    public var mode: Mode = .creation
    public var exercises: [TPExercise] = []
    public var profileValues: [String] = []
    private var training: TPTraining = TPTraining()
    public var userId: Int?
    public var trainingsService: TPTrainingService?
    public var onSaveHandler: OnSaveHandler?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        switch mode {
        case .edit(training: let trainingToEdit):
            self.training = trainingToEdit
        default:
            break
        }
        
        configureTrainingView()
        configureFloatingView()
        configureNavigationBar()
        configureSaveButtonEnabled()
    }
    
    // MARK: - Actions and Action Callbacks
    @objc
    private func saveButtonTapped() {
        guard let userId = userId else { fatalError() }
        switch mode {
        case .creation:
            trainingsService?.addTraining(training, userId: userId, completion: { result in
                self.onSaveHandler?()
                switch result {
                case .success:
                    self.navigationController?.popViewController(animated: true)
                case .failure:
                    self.navigationController?.popViewController(animated: true)
                }
            })
        case .edit:
            trainingsService?.editTraining(training: training, userId: userId, completion: { result in
                self.onSaveHandler?()
                switch result {
                case .success:
                    self.navigationController?.popViewController(animated: true)
                case .failure:
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }
    }
}

private extension TPNewTrainingViewController {
    func animateFloatingView(isVisible: Bool) {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut], animations: {
            
            let delta: CGFloat = isVisible ? 50 : -50
            self.addSectionFloatingViewTopConstraint.constant += delta
            self.view.layoutIfNeeded()
            
        }, completion: { _ in })
    }
    
    func configureTrainingView() {
        listView.configure(withAllowedExercises: exercises, profileValues: profileValues)
        listView.configure(withTraining: training)
        listView.configureCommon()
        listView.viewDelegate = self
    }
    
    func configureFloatingView() {
        addSectionFloatingView.viewDelegate = self
        addSectionFloatingView.isHidden = false
        addSectionFloatingViewTopConstraint.constant -= 50
        floatingViewContainerView.clipsToBounds = true
    }
    
    func configureNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem?.title = "Сохранить"
    }
    
    func configureSaveButtonEnabled() {
        guard
            let name = training.name,
            let description = training.descriptionText,
            let sections = training.sections
        else {
            navigationItem.rightBarButtonItem?.isEnabled = false
            return
        }
        guard !name.isEmpty && !description.isEmpty && !sections.isEmpty else {
            navigationItem.rightBarButtonItem?.isEnabled = false
            return
        }
        for section in sections {
            guard sectionValid(section: section) else {
                navigationItem.rightBarButtonItem?.isEnabled = false
                return
            }
        }
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    func sectionValid(section: TPTrainingSection) -> Bool {
        switch section {
        case .rest(minutes: _, name: let name):
            return !(name ?? "").isEmpty
        case .amrap, .forTime, .emom:
            guard let items = section.items,
                  let name = section.name,
                  !name.isEmpty
            else {
                return false
            }
            
            for item in items {
                guard sectionItemValid(item: item) else {
                    return false
                }
            }
        }
        return true
    }
    
    func sectionItemValid(item: TPTrainingSectionItem) -> Bool {
        return item.exerciseId != nil
    }
}

extension TPNewTrainingViewController: TPTrainingViewDelegate {
    public func tpTrainingViewTrainingChanged(_ sender: TPTrainingView, training: TPTraining) {
        self.training = training
        configureSaveButtonEnabled()
    }
    
    public func tpTrainingViewAddSectionVisibilityChange(_ sender: TPTrainingView, isVisible: Bool) {
        animateFloatingView(isVisible: !isVisible)
    }
}

extension TPNewTrainingViewController: TPTrainingAddEntityViewDelegate {
    public func tpTrainingAddEntityViewButtonDidTap(_ sender: TPTrainingAddEntityView, userData: [AnyHashable : Any]?) {
        listView.addSection()
    }
}
