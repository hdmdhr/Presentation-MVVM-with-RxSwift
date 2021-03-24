//
//  MyApiClient.swift
//  Presentation-MVVM with RxSwift
//
//  Created by 胡洞明 on 2021-03-24.
//

import Foundation
import Alamofire
import RxSwift
import RxAlamofire

class MyApiClient: AApiClient {
    
    private let url = "https://sample-api-dao.herokuapp.com/places"
    
    func getPlaces(placeType: PlaceType?, keyword: String?) -> Observable<[PlaceRemote]> {
        let parameters: Parameters = ["type": placeType?.rawValue,
                                      "search": keyword].compactMapValues{$0}
        
        return request(.get, url, parameters: parameters, encoding: URLEncoding.queryString)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .debug()
            .data()
            .decode(type: [PlaceRemote].self, decoder: JSONDecoder())
    }
    
}
