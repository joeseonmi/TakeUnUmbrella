//
//  DownloadBGModel.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/12/11.
//  Copyright © 2019 조선미. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct DownloadBGViewModel: DownloadBGViewBindable {
    var viewWillAppear = PublishSubject<Void>()
    var loadBGs: Driver<[BGImage]>
    
    var disposeBag = DisposeBag()
    
    init(model: DownloadBGModel = DownloadBGModel()) {
        let loadBGsFormFB = viewWillAppear
            .flatMapLatest(model.getBGs)
            .asObservable()
            .share()
        
   
        loadBGs = loadBGsFormFB
            .map({ snapShot -> [BGImage] in
                return snapShot.documents.map { BGImage(dic: $0.data() as! [String: String]) }
            })
            .asDriver(onErrorDriveWith: .empty())
    }
}
