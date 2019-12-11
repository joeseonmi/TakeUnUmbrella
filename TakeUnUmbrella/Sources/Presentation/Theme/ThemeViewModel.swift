//
//  ThemeViewModel.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/12/11.
//  Copyright © 2019 조선미. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct ThemeViewModel: ThemeViewBindable {
    var viewWillAppear = PublishSubject<Void>()
    
    
    var disposeBag = DisposeBag()
    
    init(model: ThemeModel = ThemeModel()) {
        
    }
}
