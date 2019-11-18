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
    case getCurrentWeather(lat: String, lon: String)
    case getDangiFcst
    case getForecast
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
            return "/getForecastTimeData"
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
        case .getCurrentWeather:
            var parameter = [String: String]()
            parameter["ServiceKey"] = AppConstants.AppKey.appKey.removingPercentEncoding!
            parameter["base_date"] = "20191118"
            parameter["base_time"] = "1600"
            parameter["nx"] = "60"
            parameter["ny"] = "120"
            parameter["_type"] = "json"
            return .requestParameters(parameters: parameter, encoding: URLEncoding.queryString)
        case .getDangiFcst:
            return .requestPlain
        case .getForecast:
            var parameter = [String: String]()
            parameter["ServiceKey"] = AppConstants.AppKey.appKey.removingPercentEncoding!
            parameter["base_date"] = "20191116"
            parameter["base_time"] = "2200"
            parameter["nx"] = "60"
            parameter["ny"] = "120"
            parameter["_type"] = "json"
            return .requestParameters(parameters: parameter, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }

}
