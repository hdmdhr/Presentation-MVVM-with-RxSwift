//
//  UICollectionView+Dequeue.swift
//  Presentation-MVVM with RxSwift
//
//  Created by 胡洞明 on 2021-03-24.
//

import UIKit

extension UICollectionView {
    
    func dequeueCell<T:UICollectionViewCell>(_ cellType: T.Type, for ip: IndexPath) -> T {
        dequeueReusableCell(withReuseIdentifier: String(describing: cellType), for: ip) as! T
    }
    
}
