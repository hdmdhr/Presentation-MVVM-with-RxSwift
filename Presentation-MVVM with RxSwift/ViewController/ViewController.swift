//
//  ViewController.swift
//  Presentation-MVVM with RxSwift
//
//  Created by 胡洞明 on 2021-03-22.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    let subject = PublishSubject<Void>()
    var o1: Observable<Int>!
    var o2: Observable<Int>!
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // demo - Event enum
        subject.on(Event<Void>.completed)
        
        
        
        // demo - just, of, from
        o1 = Observable.just(1)
        o1 = Observable.of(1, 2)
        o1 = Observable.from([1, 2, 3])
        
        // demo - empty()
        o1 = .empty()
        
        // demo - error()
        o1 = .error(NSError(domain: "", code: 0))
        
        
        
        // demo - subscribe
        o2 = .of(1, 2)
        var subscription: Disposable?
        
        demo(of: "subscribe on event", step: .subscribe) {
    //        o2.subscribe(<#T##on: (Event<Int>) -> Void##(Event<Int>) -> Void#>)
            o2.subscribe{ print($0) }
        }
        
        demo(of: "subscribe on event - switch event", step: .subscribe) {
            subscription = o2.subscribe { event in
                switch event {
                case .next(let element): print(element)
                case .error(let err): print(err)
                case .completed: print("completed")
                }
            }
        }
        
        demo(of: "subscribe on next", step: .subscribe) {
//            o2.subscribe(onNext: <#T##((Int) -> Void)?##((Int) -> Void)?##(Int) -> Void#>, onError: <#T##((Error) -> Void)?##((Error) -> Void)?##(Error) -> Void#>, onCompleted: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>, onDisposed: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
            subscription = o2.subscribe(onNext: { print($0) },
                             onError: { print($0) },
                             onCompleted: { print("completed") },
                             onDisposed: { print("disposed") })
        }
        
        demo(of: "dispose subscription", step: .subscribe) {
            subscription?.dispose()
//            subscription?.disposed(by: <#T##DisposeBag#>)
            subscription?.disposed(by: bag)
        }
        
        
        
        // demo - subjects
        
        demo(of: "PublishSubject", step: .subjects) {
            let ps = PublishSubject<Int>()
            let now = Date()
            
            let timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { t in
                let secondsFromNow = Int(t.fireDate.timeIntervalSince(now))
                ps.onNext(secondsFromNow)
                if secondsFromNow >= 6 {
                    ps.onCompleted()
                }
            }
            
            ps
                .subscribe(onNext: { print($0) },
                           onError: { print($0) },
                           onCompleted: { print("completed") },
                           onDisposed: {
                            timer.invalidate()
                            print("timer invalidated")
                           })
                .disposed(by: bag)
        }
        
        
        // demo - relay
        
        demo(of: "Relay", step: .relay) {
            let pr: PublishRelay<Int> = .init()
            let br: BehaviorRelay<Int> = .init(value: 0)
            let rr: ReplayRelay<Int> = .create(bufferSize: 2)
            
            pr.accept(0)
            br.accept(1)
            rr.accept(0)
            rr.accept(1)
            rr.accept(2)
            
            _ = pr.bind(onNext: { print("pr: ", $0) })
            _ = br.bind(onNext: { print("br: ", $0) })
            _ = rr.bind(onNext: { print("rr: ", $0) })
        }
        
        
        // demo - RxCocoa binding method
        
        demo(of: "RxCocoa", step: .rxcocoa) {
            Observable.just("button title")
                .bind(to: UIButton().rx.title(for: []))
                .disposed(by: bag)
        }
    }


}

