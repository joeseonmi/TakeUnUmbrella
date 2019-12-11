//
//  BGImage.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/12/11.
//  Copyright © 2019 조선미. All rights reserved.
//

import Foundation

struct BGImage {
    let imageURL: String
    
    init(dic: [String: String]) {
        self.imageURL = dic["imageURL"] as! String
    }
}
