//
//  Utils.swift
//  Presentation-MVVM with RxSwift
//
//  Created by 胡洞明 on 2021-03-22.
//

import Foundation

public func demo(of description: String, step: DemoStep, action: () -> Void) {
    guard step == G_demoStep else { return }
    
    print("\n--- Demo:", description, "---")
    action()
}
