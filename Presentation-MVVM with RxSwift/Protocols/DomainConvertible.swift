//
//  DomainConvertible.swift
//  Presentation-MVVM with RxSwift
//
//  Created by 胡洞明 on 2021-03-24.
//

import Foundation

protocol DomainConvertible {
    associatedtype Domain
    
    var toDomain: Domain { get }
}
