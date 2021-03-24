//
//  AApiClient.swift
//  Presentation-MVVM with RxSwift
//
//  Created by 胡洞明 on 2021-03-24.
//

import RxSwift

protocol AApiClient {
    func getPlaces(placeType: PlaceType?) -> Observable<[PlaceRemote]>
}
