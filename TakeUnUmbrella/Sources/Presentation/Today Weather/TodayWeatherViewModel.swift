//
//  TodayWeatherViewModel.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/11/15.
//  Copyright © 2019 조선미. All rights reserved.
//

import Foundation
import CoreLocation

import RxSwift
import RxCocoa
import RxOptional

import RxRealm

struct TodayWeatherViewModel: TodayWeatherViewBindable {
    let disposeBag = DisposeBag()
    
    var currentWeatherData: Driver<[ForecastItem]>
    var viewWillAppear = PublishSubject<CLLocation?>()
    var forecastWeatherData: Driver<[[ForecastItem]]>
    var maxMinTempData: Driver<MaxMinToday>
    var push: Driver<UIViewController>
    var tappedMenu = PublishRelay<Void>()
    
    init(model: TodayWeatherModel = TodayWeatherModel()) {
        
        //오늘의 최고, 최저기온을 받아옴
        let maxMinTempData = viewWillAppear
            .filterNil()
            .map {
                model.makeMaxMinTempParameter(lat: $0.coordinate.latitude, lon: $0.coordinate.longitude)
            }
            .flatMapLatest(model.getForecast)
            .debug("두시데이터")
            .asObservable()
            .share()
        
       self.maxMinTempData = maxMinTempData
        .map { result -> MaxMinToday in
            guard case .success(let value) = result else {
                return MaxMinToday(max: "-", min: "-")
            }
            return model.parsMaxMinData(value: value.response.body.items.item)
        }
        .asDriver(onErrorDriveWith: .empty())
        
        
        //날씨 예보를 받아옴 - 현재
        let forecastWeather = viewWillAppear
            .filterNil()
            .map {
                model.makeCurrentParameter(lat: $0.coordinate.latitude, lon: $0.coordinate.longitude)
            }
            .flatMapLatest(model.getDangi)
            .debug("현재 날씨")
            .asObservable()
            .share()
        
        let forecastValue = forecastWeather.map { result -> [WeatherItem]? in
            guard case .success(let value) = result else {
                return nil
            }
            return value.response.body.items.item
        }
        .filterNil()
        
        let forecastError = forecastWeather.map { result -> String? in
            guard case .failure(let error) = result else {
                return nil
            }
            return error.message
        }
        
        self.currentWeatherData = forecastValue
            .map(model.parsDangiData)
            .asDriver(onErrorDriveWith: .empty())
    
        //날씨 예보를 받아옴
        let weatherResult = viewWillAppear
            .filterNil()
            .map {
                model.makeSpaceParameter(lat: $0.coordinate.latitude, lon: $0.coordinate.longitude)
            }
            .flatMapLatest(model.getForecast)
            .debug("날씨 예보")
            .share()
        
        self.forecastWeatherData = weatherResult
            .map { result -> [[ForecastItem]] in
                guard case .success(let value) = result else {
                    return []
                }
                return model.parsForecastData(value: value.response.body.items.item)
            }
            .asDriver(onErrorDriveWith: .empty())
            
        self.push = tappedMenu
            .map { _ in
                let nextViewCon = SettingViewController()
                nextViewCon.modalPresentationStyle = .fullScreen
                let viewModel = SettingViewModel()
                nextViewCon.bind(viewModel: viewModel)
                return nextViewCon
        }
        .asDriver(onErrorDriveWith: .empty())

        //        let currentWeather = viewWillAppear
        //            .flatMapLatest { _ in
        //                model.getCurrentWeather()
        //        }
        //            .asObservable()
        //            .share()
        //
        //        let weatherValue = currentWeather
        //            .map { result -> [GribItem]? in
        //                guard case .success(let value) = result else {
        //                    return nil
        //                }
        //                return value.response.body.items.item
        //        }
        //        .filterNil()
        //
        //        let weatherError = currentWeather
        //            .map { result -> String? in
        //                guard case .failure(let error) = result else {
        //                    return nil
        //                }
        //                return error.message
        //        }
        //        .filterNil()
        //
        //        let currentDataNetWorking = Observable
        //            .combineLatest(viewWillAppear, checkParameter.filterNil())
        //            .map { model.makeDangiParameter(lat: $1.coordinate.latitude, lon: $1.coordinate.longitude) }
        //            .flatMapLatest(model.getDangi)
        //            .asObservable()
        //            .share()
        
        let checkParameter = viewWillAppear //여기서 파라미터 체크해주고, 파라미터 변경이 있으면 리턴해주고싶음
                  .filterNil()
                  .map { location -> CLLocation? in
                      let nx = location.coordinate.latitude
                      let ny = location.coordinate.longitude
                      let beforeCoord = UserDefaults.standard.string(forKey: AppConstants.UserDefaultKey.currentCoordinate)
                      return "\(nx+ny)" != beforeCoord ? location : nil
                  }
                  .asObservable()
              
    }
    
    
}
