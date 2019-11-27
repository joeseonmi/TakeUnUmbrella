//
//  WeatherGrib.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/11/16.
//  Copyright © 2019 조선미. All rights reserved.
//

import Foundation

struct GribFcstResponse: Codable {
    let response: GribFcstResponseBody
}

struct GribFcstResponseBody: Codable {
    let body: GribFcstResponseBodyItems
}

struct GribFcstResponseBodyItems: Codable {
    let items: GribFcstResponseBodyItem
}

struct GribFcstResponseBodyItem: Codable {
    let item: [GribItem]
}

struct GribItem: Codable {
    let baseDate: Int
    let baseTime: Int
    let category: GribCode
    let nx: Int
    let ny: Int
    let obsrValue: Double
}

enum GribCode: String, Codable {
    case temperature        = "T1H"
    case rainfallAnHour     = "RN1"
    case eastWestWind       = "UUU"
    case northSouthWind     = "VVV"
    case Humidity           = "REH"
    case precipitationForm  = "PTY"
    case windDirection      = "VEC"
    case windSpeed          = "WSD"
    case sky                = "SKY"
    case thunder            = "LGT"
    case precipitationPer   = "POP"
    case rainfallAn6Hours   = "R06"
    case snowfallAn6Hours   = "S06"
    case temperAn3Hours     = "T3H"
    case minTemper          = "TMN"
    case maxTemper          = "TMX"
    case wave               = "WAV"
}
