//
//  ViewController.swift
//  Presentation-MVVM with RxSwift
//
//  Created by 胡洞明 on 2021-03-22.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    let subject = PublishSubject<Void>()
    var o1: Observable<Int>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // demo Event enum
        subject.on(Event<Void>.completed)
        
        // demo just, of, from
        o1 = Observable.just(1)
        o1 = Observable.of(1, 2)
        o1 = Observable.from([1, 2, 3])
        
        // demo empty()
        o1 = .empty()
        
        // demo error()
        o1 = .error(NSError(domain: "", code: 0))
    }


}

