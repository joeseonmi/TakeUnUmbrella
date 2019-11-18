//
//  TodayWeatherViewModel.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/11/15.
//  Copyright © 2019 조선미. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxOptional

struct TodayWeatherViewModel: TodayWeatherViewBindable {
    
    let disposeBag = DisposeBag()
    
    var viewWillAppear = PublishSubject<Void>()
    var tappedNext = PublishRelay<Void>()
    var currentWeatherData: Driver<[GribItem]>
    var push: Driver<UIViewController>
    
    init(model: TodayWeatherModel = TodayWeatherModel()) {
      
        let weatherListResult = viewWillAppear
            .flatMapLatest { _ in model.getCurrentWeather() }
            .asObservable()
            .share()
       
        let weatherValue = weatherListResult
            .map { result -> [GribItem]? in
                guard case .success(let value) = result else {
                    return nil
                }
                return value.response.body.items.item
        }
        .filterNil()

        let weatherError = weatherListResult
            .map { result -> String? in
                guard case .failure(let error) = result else {
                    return nil
                }
                return error.message
        }
        .filterNil()
        
        currentWeatherData = weatherValue
            .asDriver(onErrorDriveWith: .empty())
        
        self.push = tappedNext
            .map { _ in
                let nextViewCon = UIViewController()
                nextViewCon.title = "다음 뷰 컨트롤러에염!"
                nextViewCon.view.backgroundColor = .white
                nextViewCon.modalPresentationStyle = .fullScreen
                return nextViewCon
            }
            .asDriver(onErrorDriveWith: .empty())
       
    }
}
