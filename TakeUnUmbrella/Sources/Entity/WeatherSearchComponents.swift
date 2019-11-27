//
//  WeatherSearchComponents.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/11/16.
//  Copyright © 2019 조선미. All rights reserved.
//

import Foundation
import RxRealm
import RealmSwift

struct WeatherSearchComponents: Codable {
    let serviceKey: String
    let baseDate: String
    let baseTime: String
    let nx: String
    let ny: String
    let type: String
    let numOfRows: String
}

class Parameters: Object {
    @objc let parameterID: Int = 0
    @objc let baseDate: String = ""
    @objc let baseTime: String = ""
    @objc let nx: String = ""
    @objc let ny: String = ""
    
    override class func primaryKey() -> String? {
        return "parameterID"
    }
}
