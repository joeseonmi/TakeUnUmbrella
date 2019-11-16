//
//  WeatherNetworkImpl.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/11/15.
//  Copyright © 2019 조선미. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class WeatherNetworkImpl: WeatherNetwork {
    
    let provider = MoyaProvider<WeatherAPI>()
  
    func getCurrentWeather() -> Single<WeatherResult<GribFcstResponse>> {
        return provider.rx.request(
            .getCurrentWeather(lat: "60", lon: "120")
        )
        .filterSuccessfulStatusCodes()
        .map { res in
            try JSONDecoder().decode(GribFcstResponse.self, from: res.data)
        }
        .map { .success($0) }
    }
}

