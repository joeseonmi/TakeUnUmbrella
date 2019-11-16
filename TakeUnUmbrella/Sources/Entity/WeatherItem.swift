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
}

//MARK: 🐶 SingleValue 알아보기
//해당 부분은 Any는 Cadable에서 쓸 수 없기 때문에 처리해준 부분
enum FcstTime: Codable {
    
    case string(String)
    case int(Int)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let temp = try? container.decode(String.self) {
            self = .string(temp)
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
        case .string(let value):
            try container.encode(value)
        case .int(let value):
            try container.encode(value)
            
        }
    }
}
