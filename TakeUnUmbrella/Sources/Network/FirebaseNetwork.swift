//
//  FirebaseNetwork.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/12/10.
//  Copyright © 2019 조선미. All rights reserved.
//

import Foundation
import RxSwift
import Firebase

enum FirebaseNetworkError: Error {
    case error(String)
    case defaultError
    
    var message: String? {
        switch self {
        case let .error(msg):
            return msg
        case .defaultError:
            return "잠시 후에 다시 시도해주세요."
        }
    }
}

protocol FirebaseNetwork {
    typealias FirebaseResult<T> = Result<T, FirebaseNetworkError>
    func getNotices() -> Observable<QuerySnapshot>
    func getBGImages() -> Observable<QuerySnapshot>
}
