//
//  ThemeModel.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/12/11.
//  Copyright © 2019 조선미. All rights reserved.
//

import Foundation

struct ThemeModel {
  
    let themeNetwork: FirebaseNetwork
    
    init(firebaseNetwork: FirebaseNetwork = FirebaseNetworkImpl()) {
        self.themeNetwork = firebaseNetwork
    }
    
    
}
