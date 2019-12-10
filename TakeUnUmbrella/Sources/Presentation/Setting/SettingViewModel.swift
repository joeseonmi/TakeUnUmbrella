//
//  SettingViewModel.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/12/10.
//  Copyright © 2019 조선미. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

struct SettingViewModel: SettingViewBindable {
    var tappedCell = PublishRelay<IndexPath>()
    var push: Driver<UIViewController>
    
    let disposeBag = DisposeBag()
    
    init(model: SettingModel = SettingModel()) {
        self.push = tappedCell
            .map { index -> UIViewController in
                switch index.row {
                case 0:
                    let nextVC = NoticeViewController()
                    let nextVM = NoticeViewModel()
                    nextVC.bind(nextVM)
                    return nextVC
                default:
                    let nextVC = NoticeViewController()
                    let nextVM = NoticeViewModel()
                    nextVC.bind(nextVM)
                    return nextVC
                }
            }
            .asDriver(onErrorDriveWith: .empty())
    }
}
