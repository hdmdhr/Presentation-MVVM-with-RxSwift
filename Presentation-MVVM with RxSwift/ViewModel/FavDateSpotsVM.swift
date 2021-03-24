//
//  FavDateSpotsVM.swift
//  Presentation-MVVM with RxSwift
//
//  Created by 胡洞明 on 2021-03-23.
//

import RxSwift
import RxDataSources
import Action


class FavDateSpotsVM {
    
    let apiClient: AApiClient
    
    // MARK: - Init
    
    init(apiClient: AApiClient) {
        self.apiClient = apiClient
    }
    
    
    // MARK: - Definition
    
    typealias TableSection = AnimatableSectionModel<Int, PlaceUi>
    
    
    // MARK: - Get Places Action
    
    /// Input: `PlaceType?` to query places by type; Output: `[TableSection]` to drive UITableView
    private(set) lazy var getPlacesAction: Action<PlaceType?, [TableSection]> = .init(workFactory: { [unowned self] placeType in
        self.apiClient.getPlaces(placeType: placeType)
            .map{ TableSection(model: 0, items: $0.map(\.toDomain).map(\.toUi)) }
            .map{ [$0] }
            .observe(on: MainScheduler.instance)
    })
    
}
