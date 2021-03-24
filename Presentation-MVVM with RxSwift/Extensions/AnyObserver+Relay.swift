//
//  AnyObserver+Relay.swift
//  Been N Gone
//
//  Created by 胡洞明 on 2021-02-16.
//  Copyright © 2021 LittleBitEverything. All rights reserved.
//

import RxSwift
import RxCocoa

extension AnyObserver {
    static func create<E>(_ relay: PublishRelay<E>) -> AnyObserver<E> {
        return .init { event in
            guard case let .next(value) = event else { return }
            relay.accept(value)
        }
    }

    static func create<E>(_ relay: BehaviorRelay<E>) -> AnyObserver<E> {
        return .init { event in
            guard case let .next(value) = event else { return }
            relay.accept(value)
        }
    }
}
