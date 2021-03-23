//
//  FavDateSpotsVC.swift
//  Presentation-MVVM with RxSwift
//
//  Created by 胡洞明 on 2021-03-23.
//

import UIKit
import RxSwift
import RxCocoa

class FavDateSpotsVC: UIViewController, BindableType {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var table: UITableView!
    
    var vm: FavDateSpotsVM!
    
    // rx
    let bag = DisposeBag()
    
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
        let o = Observable.just(["Restaurant", "Gym", "Theatre"])
        o
            .bind(to: table.rx.items(cellIdentifier: "Cell")) { row, data, cell in
                cell.textLabel?.text = data + " \(row)"
            }
            .disposed(by: bag)
        
        o
            .bind(to: collection.rx.items(cellIdentifier: "FilterButtonCollectionCell", cellType: FilterButtonCollectionCell.self)) { row, data, cell in
                cell.filterButton.setTitle(data, for: [])
            }
            .disposed(by: bag)
    }

}
