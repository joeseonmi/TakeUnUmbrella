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
    
    
    init(model: TodayWeatherModel = TodayWeatherModel()) {
      
        let weatherListResult = viewWillAppear
            .flatMapLatest { _ in model.getCurrentWeather() }
            .asObservable()
            .share()
       
        let weatherValue = weatherListResult
            .map { result -> GribFcstResponse? in
                guard case .success(let value) = result else {
                    return nil
                }
                return value
        }
        .filterNil()
        .subscribe(onNext: { data in
            print(data)
        })
        
        let weatherError = weatherListResult
            .map { result -> String? in
                guard case .failure(let error) = result else {
                    return nil
                }
                return error.message
        }
        .filterNil()

    }
}
