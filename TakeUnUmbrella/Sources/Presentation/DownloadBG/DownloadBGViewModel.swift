//
//  DownloadBGViewModel.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/12/11.
//  Copyright © 2019 조선미. All rights reserved.
//

import Foundation

import Firebase
import RxSwift
import RxCocoa

struct DownloadBGModel {
    
    var firebaseNetwork: FirebaseNetwork
  
    init(firebaseNetwork: FirebaseNetwork = FirebaseNetworkImpl()) {
        self.firebaseNetwork = firebaseNetwork
    }
    
    func getBGs() -> Observable<QuerySnapshot> {
        return firebaseNetwork.getBGImages()
    }
}
