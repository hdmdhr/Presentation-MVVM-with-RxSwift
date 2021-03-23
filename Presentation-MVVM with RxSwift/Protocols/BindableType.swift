
import UIKit
import RxSwift

protocol BindableType {
    associatedtype ViewModelType
    
    var vm: ViewModelType! { get set }
    
    func bindViewModel()
}

extension BindableType where Self: UIViewController {
    mutating func bindViewModel(to model: Self.ViewModelType) {
        vm = model
        loadViewIfNeeded()
        bindViewModel()
    }
}
