//
//  FirebaseNetworkImpl.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/12/10.
//  Copyright © 2019 조선미. All rights reserved.
//

import Foundation
import Firebase
import RxFirebase
import RxSwift

class FirebaseNetworkImpl: FirebaseNetwork {

    let fireStore = Firestore.firestore()
    
    func getNotices() -> Observable<QuerySnapshot> {
        return fireStore.collection("Notice")
            .limit(to: 15)
            .rx
            .getDocuments()
    }
    
    func getBGImages() -> Observable<QuerySnapshot> {
        return fireStore.collection("BGImage")
            .limit(to: 15)
            .rx
            .getDocuments()
    }
    

}
