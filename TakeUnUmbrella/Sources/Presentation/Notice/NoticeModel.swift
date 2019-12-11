//
//  NoticeModel.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/12/10.
//  Copyright © 2019 조선미. All rights reserved.
//

import Foundation
import RxSwift
import Firebase

struct  NoticeModel {
    //네트워크는 파이어베이스 관련으로
    let firebaseNetwork: FirebaseNetwork
    
    init(firebaseNetwork: FirebaseNetwork = FirebaseNetworkImpl()) {
        self.firebaseNetwork = firebaseNetwork
    }
    
    func getNotice() -> Observable<QuerySnapshot> {
        return firebaseNetwork.getNotices()
    }
}
