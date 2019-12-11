//
//  NoticeViewModel.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/12/10.
//  Copyright © 2019 조선미. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxOptional

struct NoticeViewModel: NoticeBindable {
    var selectedItem = PublishRelay<IndexPath>()
    var viewWillAppear = PublishRelay<Void>()
    var loadNotices: Driver<[Notice]>
    
    init(model: NoticeModel = NoticeModel()) {
        var disposeBag = DisposeBag()
        
        let notice = viewWillAppear
            .flatMapLatest(model.getNotice)
            .asObservable()
            .share()
        
        loadNotices = notice
            .map({ data -> [Notice] in
               return data.documents.map { Notice(dic: $0.data() as! [String: Any]) }
            })
            .asDriver(onErrorDriveWith: .empty())
    }
    
  
}
