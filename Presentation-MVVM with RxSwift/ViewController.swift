//
//  ViewController.swift
//  Presentation-MVVM with RxSwift
//
//  Created by 胡洞明 on 2021-03-22.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    let o = PublishSubject<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        o.on(Event<Void>.completed)
    }


}

