//
//  FavDateSpotsVC.swift
//  Presentation-MVVM with RxSwift
//
//  Created by 胡洞明 on 2021-03-23.
//

import UIKit

class FavDateSpotsVC: UIViewController, BindableType {

    var vm: FavDateSpotsVM!
    
    // MARK: - Init
    
    static func initWith(vm: ViewModelType) -> FavDateSpotsVC {
        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        var vc = mainStoryboard.instantiateViewController(identifier: String(describing: self)) as! FavDateSpotsVC
        vc.bindViewModel(to: vm)
        return vc
    }
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Binding
    
    func bindViewModel() {
        
    }

}
