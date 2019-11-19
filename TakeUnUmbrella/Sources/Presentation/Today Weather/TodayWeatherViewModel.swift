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
    var willDisplayCell = PublishRelay<IndexPath>() //이건 Paging 하려고 썼던듯..
    var currentWeatherData: Driver<[GribItem]>
    var forecastWeatherData: Driver<[WeatherItem]>
    var push: Driver<UIViewController>
//    var cellData: Driver<[WeatherItem]>
//    var reloadList: Signal<Void>
    
//    var cells = BehaviorRelay<[WeatherItem]>(value: [])
    
    init(model: TodayWeatherModel = TodayWeatherModel()) {
      
        let currentWeather = viewWillAppear
            .flatMapLatest { _ in
                model.getCurrentWeather()
        }
            .asObservable()
            .share()
       
        let weatherValue = currentWeather
            .map { result -> [GribItem]? in
                guard case .success(let value) = result else {
                    return nil
                }
                return value.response.body.items.item
        }
        .filterNil()

        let weatherError = currentWeather
            .map { result -> String? in
                guard case .failure(let error) = result else {
                    return nil
                }
                return error.message
        }
        .filterNil()
        
        let forecastWeather = viewWillAppear
            .flatMapLatest(model.getForecast)
            .asObservable()
            .share()
        
        let forecastValue = forecastWeather.map { result -> [WeatherItem]? in
            guard case .success(let value) = result else {
                return nil
            }
            print(value.response.body.items.item)
            return value.response.body.items.item
        }
        .filterNil()
        
        forecastWeatherData = forecastValue
                   .asDriver(onErrorDriveWith: .empty())
        
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
       
        
//        self.cellData = cells
//            .asDriver(onErrorDriveWith: .empty())
//        
//        self.reloadList = forecastValue
//            .map { _ in Void() }
//            .asSignal(onErrorSignalWith: .empty())
    }
}
