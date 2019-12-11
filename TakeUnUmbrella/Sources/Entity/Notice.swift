//
//  Notice.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/12/11.
//  Copyright © 2019 조선미. All rights reserved.
//

import Foundation
import Firebase

struct Notice {
    let title: String
    let contents: String
    let createdAt: Timestamp
    
    init(dic: [String: Any]) {
        self.title = dic["title"] as! String
        self.contents = dic["contents"] as! String
        self.createdAt = dic["createdAt"] as! Timestamp
    }
}
