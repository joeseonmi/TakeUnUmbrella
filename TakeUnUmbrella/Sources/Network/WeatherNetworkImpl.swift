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
  
    func getCurrentWeather(components: WeatherSearchComponents) -> Single<WeatherResult<GribFcstResponse>> {
        return provider.rx.request(
            .getCurrentWeather(components: components)
        )
        .filterSuccessfulStatusCodes()
        .map { res in
            try JSONDecoder().decode(GribFcstResponse.self, from: res.data)
        }
        .map { .success($0) }
    }
    
    func getDangi(components: WeatherSearchComponents) -> Single<WeatherResult<WeatherFcstResponse>> {
        return provider.rx.request(
            .getDangiFcst(components: components)
        )
            .filterSuccessfulStatusCodes()
            .map { res in
                return try JSONDecoder().decode(WeatherFcstResponse.self, from: res.data)
        }
        .map { .success($0) }
    }

    func getForecast(components: WeatherSearchComponents) -> Single<WeatherResult<WeatherFcstResponse>> {
        return provider.rx.request(
            .getForecast(components: components)
        )
            .filterSuccessfulStatusCodes()
            .map { res in
                try JSONDecoder().decode(WeatherFcstResponse.self, from: res.data)
        }
        .map { .success($0) }
    }
}

