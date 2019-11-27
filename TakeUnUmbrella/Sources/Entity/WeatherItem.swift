//
//  WeatherItem.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/11/15.
//  Copyright © 2019 조선미. All rights reserved.
//

import Foundation


struct WeatherFcstResponse: Codable {
    let response: WeatherFcstResponseBody
}

struct WeatherFcstResponseBody: Codable {
    let body: WeatherFcstResponseBodyItems
}

struct WeatherFcstResponseBodyItems: Codable {
    let items: WeatherFcstResponseBodyItem
}

struct WeatherFcstResponseBodyItem: Codable {
    let item: [WeatherItem]
}

struct WeatherItem: Codable {
    let baseDate: Int
    let baseTime: String
    let category: GribCode
    let fcstDate: Int
    var fcstTime: String
    let fcstValue: String
    let nx: Int
    let ny: Int
    
    enum Codingkeys: String, CodingKey {
        case baseDate, baseTime, category, fcstDate, fcstTime, fcstValue, nx, ny
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        baseDate = try container.decode(Int.self, forKey: .baseDate)
        if let intValue = try? container.decode(Int.self, forKey: .baseTime) {
            baseTime = "\(intValue)"
        } else {
            baseTime = try container.decode(String.self, forKey: .baseTime)
        }
        category = try container.decode(GribCode.self, forKey: .category)
        fcstDate = try container.decode(Int.self, forKey: .fcstDate)
        if let intValue = try? container.decode(Int.self, forKey: .fcstTime) {
            fcstTime = "\(intValue)"
        } else {
            fcstTime = try container.decode(String.self, forKey: .fcstTime)
        }
        if let doubleValue = try? container.decode(Double.self, forKey: .fcstValue) {
            fcstValue = "\(doubleValue)"
        } else {
            fcstValue = try container.decode(String.self, forKey: .fcstValue)
        }
        nx = try container.decode(Int.self, forKey: .nx)
        ny = try container.decode(Int.self, forKey: .ny)
    }
}
//MARK: 🐶 SingleValue 알아보기
enum FcstValue: Codable {
    
    case string(String)
    case double(Double)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
       if let temp = try? container.decode(String.self) {
                 self = .string(temp)
                 return
             }
        if let temp = try? container.decode(Double.self) {
            self = .double(temp)
            return
        }
        throw DecodingError.typeMismatch(FcstValue.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "wrong type"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let value):
            try container.encode(value)
        case .double(let value):
            try container.encode(value)
            
        }
    }
}
