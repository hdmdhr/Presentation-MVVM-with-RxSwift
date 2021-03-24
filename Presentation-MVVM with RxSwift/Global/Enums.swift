//
//  Enums.swift
//  Presentation-MVVM with RxSwift
//
//  Created by 胡洞明 on 2021-03-22.
//

import Foundation

public enum DemoStep: Int {
    case subscribe
    case subjects
    case relay
    case rxcocoa
}


enum PlaceType: String, Codable, CaseIterable {
    case Restaurant, Gym, Theatre
    
    var imageName: String {
        switch self {
        case .Restaurant where Bool.random(): return "bar"
        default: return rawValue.lowercased()
        }
    }
}
