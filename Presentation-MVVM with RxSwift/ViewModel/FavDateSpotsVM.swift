//
//  FavDateSpotsVM.swift
//  Presentation-MVVM with RxSwift
//
//  Created by 胡洞明 on 2021-03-23.
//

import RxSwift
import RxCocoa
import RxDataSources
import Action


class FavDateSpotsVM {
    
    let apiClient: AApiClient
    
    // rx
    private let rx_selectedPlaceType: BehaviorSubject<PlaceType?> = .init(value: nil)
    private let bag = DisposeBag()
    
    // MARK: - Init
    
    init(apiClient: AApiClient) {
        self.apiClient = apiClient
        
        rx_selectedPlaceType.skip(1)  // skip 1 to skip BehaviorSubject initial value
            .bind(to: getPlacesAction.inputs)
            .disposed(by: bag)
    }
    
    // MARK: - Input
    
    struct Input {
        let selectedPlaceType: AnyObserver<PlaceType?>
    }
    
    private(set) lazy var input: Input = .init(selectedPlaceType: rx_selectedPlaceType.asObserver())
    
    
    // MARK: - Output
    
    struct Output {
        let selectedPlaceType: Observable<PlaceType?>
    }
    
    private(set) lazy var output: Output = .init(selectedPlaceType: rx_selectedPlaceType.asObservable())
    
    // MARK: - Definition
    
    typealias TableSection = AnimatableSectionModel<Int, PlaceUi>
    typealias CollectionSection = AnimatableSectionModel<Int, FilterButtonCollectionCell.Data>
    
    
    // MARK: - Get Places Action
    
    /// Input: `PlaceType?` to query places by type; Output: `[TableSection]` to drive UITableView
    private(set) lazy var getPlacesAction: Action<PlaceType?, [TableSection]> = .init(workFactory: { [unowned self] placeType in
        self.apiClient.getPlaces(placeType: placeType)
            .map{ TableSection(model: 0, items: $0.map(\.toDomain).map(\.toUi)) }
            .map{ [$0] }
            .observe(on: MainScheduler.instance)
    })
    
}
