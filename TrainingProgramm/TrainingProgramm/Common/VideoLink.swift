//
//  VideoLink.swift
//  TrainingProgramm
//
//  Created by Vitali on 9/2/20.
//

import Foundation

public enum VideoLink {
    case file(url: URL)
    case remote(url: URL)
    
    var url: URL {
        get {
            switch self {
            case .file(url: let url):
                return url
            case .remote(url: let url):
                return url
            }
        }
    }
}
