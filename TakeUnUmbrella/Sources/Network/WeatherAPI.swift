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
    case getCurrentWeather(lat: String, lon: String) //실황정보 조회
    case getDangiFcst                                //초단기예보
    case getForecast                                 //특징지역의 예보
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
        case .getCurrentWeather:
            var parameter = [String: String]()
            parameter["ServiceKey"] = AppConstants.AppKey.appKey.removingPercentEncoding!
            parameter["base_date"] = "20191119"
            parameter["base_time"] = "1630"
            parameter["nx"] = "60"
            parameter["ny"] = "120"
            parameter["_type"] = "json"
            parameter["numOfRows"] = "999"
            return .requestParameters(parameters: parameter, encoding: URLEncoding.queryString)
        case .getDangiFcst:
            return .requestPlain
        case .getForecast:
            var parameter = [String: String]()
            parameter["ServiceKey"] = AppConstants.AppKey.appKey.removingPercentEncoding!
            parameter["base_date"] = "20191119"
            parameter["base_time"] = "1830"
            parameter["nx"] = "60"
            parameter["ny"] = "120"
            parameter["_type"] = "json"
            parameter["numOfRows"] = "999"
            return .requestParameters(parameters: parameter, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }

}
