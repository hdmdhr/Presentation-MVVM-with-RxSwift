//
//  FavDateSpotsVC.swift
//  Presentation-MVVM with RxSwift
//
//  Created by 胡洞明 on 2021-03-23.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Alamofire
import Action

class FavDateSpotsVC: UIViewController, BindableType {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var c_collectionHeight: NSLayoutConstraint!
    
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

    }

    // MARK: - Binding
    
    func bindViewModel() {
        // rx drive collection
        typealias CollectionSection = FavDateSpotsVM.CollectionSection
        
        let collectionDatasource = RxCollectionViewSectionedAnimatedDataSource<CollectionSection>(configureCell: { [unowned self] (ds, cv, ip, item) in
            let cell = cv.dequeueCell(FilterButtonCollectionCell.self, for: ip)
            cell.configure(for: item)
            cell.filterButton.rx.tap.map{ item.placeType }
                .bind(to: self.vm.input.selectedPlaceType)
                .disposed(by: cell.bag)
            
            return cell
        })
        
        vm.output.collectionDatasource
            .drive(collection.rx.items(dataSource: collectionDatasource))
            .disposed(by: bag)
        
        // rx drive table
        typealias TableSection = FavDateSpotsVM.TableSection
        
        let datasource = RxTableViewSectionedAnimatedDataSource<TableSection>(configureCell: { (ds, tv, ip, item) in
            let cell = tv.dequeueReusableCell(withIdentifier: String(describing: PlaceCardCell.self)) as! PlaceCardCell
            cell.configure(for: item)
            
            return cell
        })
        
        vm.getPlacesAction.elements
            .bind(to: table.rx.items(dataSource: datasource))
            .disposed(by: bag)
        
        table.rx.willEndDragging
            .map { (velocity: CGPoint, targetContentOffset) in
                velocity.y > 0  // scroll down
            }
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] down in
                self?.c_collectionHeight.constant = down ? .leastNormalMagnitude : 50
                UIView.animate(withDuration: 0.3, animations: {
                    self?.collection.superview?.layoutIfNeeded()
                })
            })
            .disposed(by: bag)
        
        // MARK: - Bind SearchBar
        
        searchBar.rx.text
            .skip(while: { $0 == nil || $0!.isEmpty })
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(to: vm.input.searchKeyword)
            .disposed(by: bag)
        
        // handle errors
        vm.getPlacesAction.underlyingError
            .bind(onNext: { [weak self] in  self?.presentErrorAlert(error: $0) })
            .disposed(by: bag)
        
        // animate loading spinner
        vm.getPlacesAction.executing
            .bind(to: spinner.rx.isAnimating)
            .disposed(by: bag)
        
        // to ensure return data can be displayed in table, fetch places after binding table datasource
        // pass nil for place type to fetch all types
        vm.getPlacesAction.execute((placeType: nil, keyword: nil))
    }

}

