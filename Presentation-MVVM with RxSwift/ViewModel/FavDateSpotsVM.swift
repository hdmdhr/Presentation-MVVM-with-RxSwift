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
    private let rx_searchKeyword: BehaviorSubject<String?> = .init(value: nil)
    private let bag = DisposeBag()
    
    // MARK: - Init
    
    init(apiClient: AApiClient) {
        self.apiClient = apiClient
        
        Observable.combineLatest(rx_selectedPlaceType, rx_searchKeyword)
            .map{ $0 }
            .skip(until: output.collectionDatasource.asObservable())
            .bind(to: getPlacesAction.inputs)
            .disposed(by: bag)
    }
    
    // MARK: - Input
    
    struct Input {
        let selectedPlaceType: AnyObserver<PlaceType?>
        let searchKeyword: AnyObserver<String?>
    }
    
    private(set) lazy var input: Input = .init(selectedPlaceType: rx_selectedPlaceType.asObserver(),
                                               searchKeyword: rx_searchKeyword.asObserver())
    
    
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
    typealias GetPlacesAction = Action<(placeType: PlaceType?, keyword: String?), [TableSection]>
    
    private(set) lazy var getPlacesAction: GetPlacesAction = .init(workFactory: { [unowned self] (placeType, keyword) in
        self.apiClient.getPlaces(placeType: placeType, keyword: keyword)
            .map{ TableSection(model: 0, items: $0.map(\.toDomain).map(\.toUi)) }
            .map{ [$0] }
            .observe(on: MainScheduler.instance)
    })
    
}
