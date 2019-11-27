//
//  WeatherAPI.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/11/15.
//  Copyright © 2019 조선미. All rights reserved.
//

import Foundation
import RxSwift
import Moya

enum WeatherAPI {
    case getCurrentWeather(components: WeatherSearchComponents) //실황정보 조회
    case getDangiFcst(components: WeatherSearchComponents)      //초단기예보
    case getForecast(components: WeatherSearchComponents)       //특징지역의 예보
}

extension WeatherAPI: TargetType {
    var baseURL: URL {
        return URL(string: URLs.API.weatherAPI)!
    }
    
    var path: String {
        switch self {
        case .getCurrentWeather:
            return "/ForecastGrib"
        case .getDangiFcst:
            return "/ForecastTimeData"
        case .getForecast:
            return "/ForecastSpaceData"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case let .getCurrentWeather(components),
             let .getDangiFcst(components),
             let .getForecast(components):
            var parameter = [String: String]()
            parameter["ServiceKey"] = components.serviceKey
            parameter["nx"] = components.nx
            parameter["ny"] = components.ny
            parameter["_type"] = components.type
            parameter["numOfRows"] = components.numOfRows
            parameter["base_time"] = components.baseTime
            parameter["base_date"] = components.baseDate
            print(parameter)
            return .requestParameters(parameters: parameter, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}
