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
    
    func getCurrentWeather(components: WeatherSearchComponents) -> Single<Result<GribFcstResponse, WeatherNetworkError>> {
        return weatherNetwork.getCurrentWeather(components: components)
    }
    
    func getDangi(components: WeatherSearchComponents) -> Single<Result<WeatherFcstResponse, WeatherNetworkError>> {
        return weatherNetwork.getDangi(components: components)
    }
    
    func getForecast(components: WeatherSearchComponents) -> Single<Result<WeatherFcstResponse, WeatherNetworkError>> {
        return weatherNetwork.getForecast(components: components)
    }
    
    func parsForecastData(value: [WeatherItem]) -> [ForecastItem] {
        var result: [ForecastItem] = []
        //예보날짜, 시간이 같은것들끼리 묶음, 해당 묶음에서 처리해야될듯
        let sort = Dictionary.init(grouping: value, by: { $0.fcstDate } )
        let sortKeys = sort.keys.sorted()
        sortKeys.forEach { key in
            guard let temp = sort[key] else { return }
            let forecastDic = Dictionary.init(grouping: temp, by: { $0.fcstTime } )
            let keys = forecastDic.keys.sorted()
            var resultItem = ForecastItem(forecastDate: "",
                                          forecastTime: "",
                                          temperature: "",
                                          rainfallPercent: "",
                                          humi: "",
                                          sky: "",
                                          skyRain: "")
            keys.forEach { key in
                guard let tempDic = forecastDic[key] else { return }
                tempDic.forEach { item in
                    resultItem.forecastDate = "\(item.fcstDate)"
                    resultItem.forecastTime = item.fcstTime
                    switch item.category {
                    case .temperAn3Hours: resultItem.temperature       = "\(item.fcstValue)"
                    case .precipitationForm: resultItem.skyRain        = "\(item.fcstValue)"
                    case .precipitationPer: resultItem.rainfallPercent = "\(item.fcstValue)"
                    case .sky: resultItem.sky                          = "\(item.fcstValue)"
                    default: break
                    }
                }
                result.append(resultItem)
            }
        }
//        print("++++++++++++\n",result,"\n++++++++++++")
        return result
    }
    func parsDangiData(value: [WeatherItem]) -> [ForecastItem] {
            var result: [ForecastItem] = []
            //예보날짜, 시간이 같은것들끼리 묶음, 해당 묶음에서 처리해야될듯
            let sort = Dictionary.init(grouping: value, by: { $0.fcstDate } )
            let sortKeys = sort.keys.sorted()
            sortKeys.forEach { key in
                guard let temp = sort[key] else { return }
                let forecastDic = Dictionary.init(grouping: temp, by: { $0.fcstTime } )
                let keys = forecastDic.keys.sorted()
                var resultItem = ForecastItem(forecastDate: "",
                                              forecastTime: "",
                                              temperature: "",
                                              rainfallPercent: "",
                                              humi: "",
                                              sky: "",
                                              skyRain: "")
                keys.forEach { key in
                    guard let tempDic = forecastDic[key] else { return }
                    tempDic.forEach { item in
                        resultItem.forecastDate = "\(item.fcstDate)"
                        resultItem.forecastTime = item.fcstTime
                        switch item.category {
                        case .temperature:       resultItem.temperature = "\(item.fcstValue)"
                        case .precipitationForm: resultItem.skyRain = "\(item.fcstValue)"
                        case .rainfallAnHour:    resultItem.rainfallPercent = "\(item.fcstValue)"
                        case .sky:               resultItem.sky = "\(item.fcstValue)"
                        case .Humidity:          resultItem.humi = "\(item.fcstValue)"
                        default: break
                        }
                    }
                    result.append(resultItem)
                }
            }
    //        print("++++++++++++\n",result,"\n++++++++++++")
            return result
        }
    
}


extension TodayWeatherModel {
    
    //처음 켜면 무조건, 그다음엔 파라미터를 비교해 보고 파라미터가 바꼈으면.
    //Viewdidload 에서 한번 해주고
    //ViewwillAppear 마다 해주면 될 것 같음 -> 여기서 뷰 모델로 위치를 보내면 될듯
    func makeCurrentParameter(lat: Double, lon: Double) -> WeatherSearchComponents {
        let dateParameter = makeCurrentTimeParamter()
        let locationParameter = convertGrid(code: "toXY", v1: lat, v2: lon)
        let parameter = WeatherSearchComponents(serviceKey: AppConstants.AppKey.appKey.removingPercentEncoding!,
                                                baseDate: dateParameter.date,
                                                baseTime: dateParameter.time,
                                                nx: "\(locationParameter.lat)",
                                                ny: "\(locationParameter.lon)",
                                                type: "json",
                                                numOfRows: "999")
        return parameter
    }
    
    func makeSpaceParameter(lat: Double, lon: Double) -> WeatherSearchComponents {
        let dateParameter = forecasetSpaceParameter()
        let locationParameter = convertGrid(code: "toXY", v1: lat, v2: lon)
        let parameter = WeatherSearchComponents(serviceKey: AppConstants.AppKey.appKey.removingPercentEncoding!,
                                                baseDate: dateParameter.date,
                                                baseTime: dateParameter.time,
                                                nx: "\(locationParameter.lat)",
                                                ny: "\(locationParameter.lon)",
                                                type: "json",
                                                numOfRows: "999")
        return parameter
    }
    
    private func makeCurrentTimeParamter() -> (date: String, time: String) {
        let now = Date()
        let dateFommater = DateFormatter()
        let timeFommater = DateFormatter()
        let minFommater = DateFormatter()
        let yesterday = now.addingTimeInterval(-24 * 60 * 60)
        
        dateFommater.dateFormat = "yyyyMMdd"
        timeFommater.dateFormat = "HH"
        minFommater.dateFormat = "mm"
        
        dateFommater.timeZone = TimeZone(secondsFromGMT: 9 * 60 * 60)
        
        var date:String = dateFommater.string(from: now)
        var time:String = timeFommater.string(from: now)
        let min:String = minFommater.string(from: now)
        let setYesterday = dateFommater.string(from: yesterday)
        
        if Int(min)! < 30 {
            let setTime = Int(time)! - 1
            if setTime < 0 {
                date = setYesterday
                time = "23"
            } else if setTime < 10 {
                time = "0"+"\(setTime)"
            } else {
                time = "\(setTime)"
            }
        }
        time = time + "00"
  
        return (date, time)
    }
    
    private func make2amTimeParamter() -> [String: String] {
        let now = Date()
        let dateFommater = DateFormatter()
        let timeFommater = DateFormatter()
        let minFommater = DateFormatter()
        let yesterday = now.addingTimeInterval(-24 * 60 * 60)
        dateFommater.dateFormat = "yyyyMMdd"
        timeFommater.dateFormat = "HH"
        minFommater.dateFormat = "mm"
        //한국시간으로 맞춰주기
        dateFommater.timeZone = TimeZone(secondsFromGMT: 9 * 60 * 60)
        
        let setYesterday:String = dateFommater.string(from: yesterday)
        var date:String = dateFommater.string(from: now)
        var time:String = timeFommater.string(from: now)
        
        if let setTime = Int(time) {
            if setTime < 2 {
                date = setYesterday
                time = "2300"
            } else {
                time = "0200"
            }
        }
        
        let parameter = ["base_date": date,
                         "base_time": time]
        return parameter
    }
    
    private func forecasetSpaceParameter() -> (date: String, time: String) {
        let now = Date()
        let dateFommater = DateFormatter()
        let timeFommater = DateFormatter()
        let minFommater = DateFormatter()
        let yesterday = now.addingTimeInterval(-24 * 60 * 60)
        
        dateFommater.dateFormat = "yyyyMMdd"
        timeFommater.dateFormat = "HH"
        minFommater.dateFormat = "mm"
        //한국시간으로 맞춰주기
        dateFommater.timeZone = TimeZone(secondsFromGMT: 9 * 60 * 60)
        
        let setYesterday:String = dateFommater.string(from: yesterday)
        var date:String = dateFommater.string(from: now)
        var time:String = timeFommater.string(from: now)
        
        //0200, 0500, 0800, 1100, 1400, 1700, 2000, 2300 제공
        //각 시간 10분 이후부터 API 제공
        guard let setTime = Int(time) else { return ("","") }
        if setTime < 2 {
            date = setYesterday
            time = "2300"
        } else if setTime < 5 {
            time = "0200"
        } else if setTime < 8 {
            time = "0500"
        } else if setTime < 11 {
            time = "0800"
        } else if setTime < 14 {
            time = "1100"
        } else if setTime < 17 {
            time = "1400"
        } else if setTime < 20 {
            time = "1700"
        } else if setTime < 23 {
            time = "2000"
        } else if setTime >= 23 {
            time = "2300"
        }
        return (date, time)
    }
    
    private func convertGrid(code:String, v1:Double, v2:Double) -> (lat: Int, lon: Int) {
        // LCC DFS 좌표변환을 위한 기초 자료
        let RE = 6371.00877 // 지구 반경(km)
        let GRID = 5.0 // 격자 간격(km)
        let SLAT1 = 30.0 // 투영 위도1(degree)
        let SLAT2 = 60.0 // 투영 위도2(degree)
        let OLON = 126.0 // 기준점 경도(degree)
        let OLAT = 38.0 // 기준점 위도(degree)
        let XO = 43 // 기준점 X좌표(GRID)
        let YO = 136 // 기1준점 Y좌표(GRID)
        //
        //
        // LCC DFS 좌표변환 ( code : "toXY"(위경도->좌표, v1:위도, v2:경도), "toLL"(좌표->위경도,v1:x, v2:y) )
        //
        let DEGRAD = Double.pi / 180.0
        let RADDEG = 180.0 / Double.pi
        
        let re = RE / GRID
        let slat1 = SLAT1 * DEGRAD
        let slat2 = SLAT2 * DEGRAD
        let olon = OLON * DEGRAD
        let olat = OLAT * DEGRAD
        
        var sn = tan(Double.pi * 0.25 + slat2 * 0.5) / tan(Double.pi * 0.25 + slat1 * 0.5)
        sn = log(cos(slat1) / cos(slat2)) / log(sn)
        var sf = tan(Double.pi * 0.25 + slat1 * 0.5)
        sf = pow(sf, sn) * cos(slat1) / sn
        var ro = tan(Double.pi * 0.25 + olat * 0.5)
        ro = re * sf / pow(ro, sn)
        var rs:[String:Double] = [:]
        var theta = v2 * DEGRAD - olon
        if (code == "toXY") {
            
            rs["lat"] = v1
            rs["lng"] = v2
            var ra = tan(Double.pi * 0.25 + (v1) * DEGRAD * 0.5)
            ra = re * sf / pow(ra, sn)
            if (theta > Double.pi) {
                theta -= 2.0 * Double.pi
            }
            if (theta < -Double.pi) {
                theta += 2.0 * Double.pi
            }
            theta *= sn
            rs["nx"] = floor(ra * sin(theta) + Double(XO) + 0.5)
            rs["ny"] = floor(ro - ra * cos(theta) + Double(YO) + 0.5)
        }
        else {
            rs["nx"] = v1
            rs["ny"] = v2
            let xn = v1 - Double(XO)
            let yn = ro - v2 + Double(YO)
            let ra = sqrt(xn * xn + yn * yn)
            if (sn < 0.0) {
                sn - ra
            }
            var alat = pow((re * sf / ra), (1.0 / sn))
            alat = 2.0 * atan(alat) - Double.pi * 0.5
            
            if (abs(xn) <= 0.0) {
                theta = 0.0
            }
            else {
                if (abs(yn) <= 0.0) {
                    let theta = Double.pi * 0.5
                    if (xn < 0.0){
                        xn - theta
                    }
                }
                else{
                    theta = atan2(xn, yn)
                }
            }
            let alon = theta / sn + olon
            rs["lat"] = alat * RADDEG
            rs["lng"] = alon * RADDEG
        }
        guard let ny = rs["ny"], let nx = rs["nx"] else { return (0, 0) }
        return (Int(nx), Int(ny))
    }
    
}

