//
//  WeatherNetwork.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/11/15.
//  Copyright © 2019 조선미. All rights reserved.
//

import Foundation
import RxSwift

enum WeatherNetworkError: Error {
    case error(String)
    case defaultError
    
    var message: String? {
        switch self {
        case let .error(msg):
            return msg
        case .defaultError:
            return "잠시 후에 다시 시도해주세요."
        }
    }
}

//MARK: 🐶 리스폰스 받을때 Single과, Observable을 Result Type으로 받는 것의 차이?
protocol WeatherNetwork {
    typealias WeatherResult<T> = Result<T, WeatherNetworkError>
    
    func getCurrentWeather() -> Single<WeatherResult<GribFcstResponse>>
    func getForecast() -> Single<WeatherResult<WeatherFcstResponse>>
}
