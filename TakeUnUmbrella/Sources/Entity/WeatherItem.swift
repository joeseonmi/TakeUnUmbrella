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
    let baseTime: Int
    let category: String
    let fcstDate: Int
    let fcstTime: FcstTime
    let fcstValue: String
    let nx: Int
    let ny: Int
    
    enum Codingkeys: String, CodingKey {
        case baseDate, baseTime, category, fcstDate, fcstTime, fcstValue, nx, ny
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        baseDate = try container.decode(Int.self, forKey: .baseDate)
        baseTime = try container.decode(Int.self, forKey: .baseTime)
        category = try container.decode(String.self, forKey: .category)
        fcstDate = try container.decode(Int.self, forKey: .fcstDate)
        fcstTime = try container.decode(FcstTime.self, forKey: .fcstTime)
        fcstValue = try container.decode(String.self, forKey: .fcstValue)
        nx = try container.decode(Int.self, forKey: .nx)
        ny = try container.decode(Int.self, forKey: .ny)
    }
}

//MARK: 🐶 SingleValue 알아보기
//해당 부분은 Any는 Cadable에서 쓸 수 없기 때문에 처리해준 부분
enum FcstTime: Codable {
    
//    case string(String)
    case int(Int)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let temp = try? container.decode(String.self) {
            guard let intValue = Int(temp) else {
                self = .int(0)
                return
            }
            self = .int(intValue)
            return
        }
        if let temp = try? container.decode(Int.self) {
            self = .int(temp)
            return
        }
        throw DecodingError.typeMismatch(FcstTime.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "wrong type"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
//        case .string(let value):
//            try container.encode(value)
        case .int(let value):
            try container.encode(value)
            
        }
    }
}
