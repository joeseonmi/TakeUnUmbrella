//
//  TodayWeatherModel.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/11/15.
//  Copyright © 2019 조선미. All rights reserved.
//

import Foundation
import RxSwift

struct TodayWeatherModel {
    
    let weatherNetwork: WeatherNetwork
    
    init(weatherNetwork: WeatherNetwork = WeatherNetworkImpl()) {
        self.weatherNetwork = weatherNetwork
    }
    
    func getCurrentWeather() -> Single<Result<GribFcstResponse, WeatherNetworkError>> {
        return weatherNetwork.getCurrentWeather()
    }
    
    func getForecast() -> Single<Result<WeatherFcstResponse, WeatherNetworkError>> {
        return weatherNetwork.getForecast()
    }
    
    func parsForecastData(value: [WeatherItem]) -> [Int: [WeatherItem]] {
        let parsDictionary = Dictionary.init(grouping: value, by: { $0.fcstDate } )
        return parsDictionary
    }
    
}
