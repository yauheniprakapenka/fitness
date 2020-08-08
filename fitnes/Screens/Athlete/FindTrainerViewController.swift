//
//  FindTrainerViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 08.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class FindTrainerViewController: UIViewController {
    
    let titleLabel = FLabel(textAligment: .center, fontSize: 18, weight: .semibold, color: .black, message: "Поиск тренера")
    let findButton = FSFSymbolButton(sfSymbol: SFSymbolEnum.magnifyingglass.rawValue)
    let backButton = FSFSymbolButton(sfSymbol: SFSymbolEnum.chevronBackward.rawValue)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func configureTitleLabel() {
        
    }
}
