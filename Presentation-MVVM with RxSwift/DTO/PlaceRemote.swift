//
//  PlaceRemote.swift
//  Presentation-MVVM with RxSwift
//
//  Created by 胡洞明 on 2021-03-24.
//

import Foundation

struct PlaceRemote: Decodable, DomainConvertible {
    let name, address: String
    let type: PlaceType
    let rating: Double
    
    var toDomain: Place {
        .init(name: name, address: address, type: type, rating: rating)
    }
}
