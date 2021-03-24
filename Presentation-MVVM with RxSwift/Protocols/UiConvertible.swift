//
//  UiConvertible.swift
//  Presentation-MVVM with RxSwift
//
//  Created by 胡洞明 on 2021-03-24.
//

import Foundation

protocol UiConvertible {
    associatedtype UiType
    
    var toUi: UiType { get }
}
