//
//  ForecastItem.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/11/27.
//  Copyright © 2019 조선미. All rights reserved.
//

import Foundation
import UIKit

struct ForecastItem {
    var forecastDate: String
    var forecastTime: String
    var temperature: String
    var rainfallPercent: String
    var humi: String
    var sky: String
    var skyRain: String
    
    func weatherIcon() -> UIImage {
        guard let time = Int(forecastTime) else { return #imageLiteral(resourceName: "Sunny") }
        let isDay = (time > 600) && (time < 2000)
        if skyRain == "0.0" {
            switch sky {
            case "1.0": return isDay ? #imageLiteral(resourceName: "Sunny"): #imageLiteral(resourceName: "Moon")
            case "3.0": return isDay ? #imageLiteral(resourceName: "LessCloudySun"): #imageLiteral(resourceName: "LessCloudyMoon")
            case "4.0": return #imageLiteral(resourceName: "ManyCloudy")
            default: return #imageLiteral(resourceName: "Sunny")
            }
        } else {
            switch skyRain {
            case "1.0", "4.0": return #imageLiteral(resourceName: "Rain")
            case "2.0": return #imageLiteral(resourceName: "RainSnow")
            case "3.0": return #imageLiteral(resourceName: "Snow")
            default: return #imageLiteral(resourceName: "ManyCloudy")
            }
        }
        //하늘상태 + 강수확률을 보고 아이콘을 뽑아줘야함
        /*
         - 하늘상태(SKY) 코드 : 맑음(1), 구름많음(3), 흐림(4)
           * 구름조금(2) 삭제 (2019.06.4)
         - 강수형태(PTY) 코드 : 없음(0), 비(1), 비/눈(2), 눈(3), 소나기(4)
         여기서 비/눈은 비와 눈이 섞여 오는 것을 의미 (진눈개비)
         */
    }
}


