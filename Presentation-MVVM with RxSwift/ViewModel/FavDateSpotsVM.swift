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
    
    let staticCollectionDatasource = Observable<[PlaceType?]>.just([nil] + PlaceType.allCases)
    
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
        let collectionDatasource: Driver<[CollectionSection]>
    }
    
    private(set) lazy var output: Output = {
        .init(collectionDatasource: Observable.combineLatest(staticCollectionDatasource, rx_selectedPlaceType)
                .map{ allTypes, selectedType in
                    [CollectionSection(model: 0,
                                       items: allTypes.map{ .init(placeType: $0, selected: $0 == selectedType) })]
                }
                .asDriver(onErrorJustReturn: [])
        )
    }()
    
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
