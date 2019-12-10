//
//  TimeParameters.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/12/07.
//  Copyright © 2019 조선미. All rights reserved.
//

import Foundation
import RealmSwift

class MaxMinParameters: Object {
    @objc let parameterID: Int = 0
    @objc let baseDate: String = ""
    @objc let baseTime: String = ""
    @objc let nx: String = ""
    @objc let ny: String = ""
    
    override class func primaryKey() -> String? {
        return "MaxMinparameterID"
    }
}
