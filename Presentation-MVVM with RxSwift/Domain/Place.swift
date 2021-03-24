//
//  Place.swift
//  Presentation-MVVM with RxSwift
//
//  Created by 胡洞明 on 2021-03-24.
//

import Foundation

struct Place: UiConvertible {
    let name, address: String
    let type: PlaceType
    let rating: Double
    
    var toUi: PlaceUi {
        .init(name: name, address: address, type: type, rating: rating)
    }
}
