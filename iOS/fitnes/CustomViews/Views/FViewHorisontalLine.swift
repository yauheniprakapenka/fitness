//
//  HorisontalLineView.swift
//  fitnes
//
//  Created by yauheni prakapenka on 30.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class FViewHorisontalLine: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        confingure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func confingure() {
        backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
