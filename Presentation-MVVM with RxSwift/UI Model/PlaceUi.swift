//
//  PlaceUi.swift
//  Presentation-MVVM with RxSwift
//
//  Created by 胡洞明 on 2021-03-24.
//

import UIKit
import RxDataSources

struct PlaceUi: IdentifiableType, Equatable {
    let name, address: String
    let type: PlaceType
    let rating: Double
    var image: UIImage? { UIImage(named: type.imageName) }
    
    var identity: String { name + address }
}
