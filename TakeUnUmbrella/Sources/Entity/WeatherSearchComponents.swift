//
//  WeatherSearchComponents.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/11/16.
//  Copyright © 2019 조선미. All rights reserved.
//

import Foundation

struct WeatherSearchComponents: Codable {
    let serviceKey: String
    let baseDate: String
    let baseTime: String
    let nx: String
    let ny: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case serviceKey = "ServiceKey"
        case baseDate = "base_date"
        case baseTime = "base_time"
        case nx
        case ny
        case type = "_type"
    }
}
