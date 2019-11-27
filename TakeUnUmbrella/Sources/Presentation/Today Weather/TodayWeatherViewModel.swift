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

struct TodayWeatherViewModel: TodayWeatherViewBindable {
    
    let disposeBag = DisposeBag()
    
    var currentWeatherData: Driver<[ForecastItem]>
    var loactionData = PublishSubject<CLLocation?>()
    var viewWillAppear = PublishSubject<Void>()
    var tappedNext = PublishRelay<Void>()
    var willDisplayCell = PublishRelay<IndexPath>()             //이건 Paging 하려고 썼던듯..
    var forecastWeatherData: Driver<[ForecastItem]>
    var push: Driver<UIViewController>
    
    init(model: TodayWeatherModel = TodayWeatherModel()) {
//
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
        let checkParameter = self.loactionData //여기서 파라미터 체크해주고, 파라미터 변경이 있으면 리턴해주고싶음
            .filterNil()
            .map { location -> CLLocation? in
                let nx = location.coordinate.latitude
                let ny = location.coordinate.longitude
                let beforeCoord = UserDefaults.standard.string(forKey: AppConstants.UserDefaultKey.currentCoordinate)
                return "\(nx+ny)" != beforeCoord ? location : nil
            }
            .asObservable()
        
//        let currentDataNetWorking = Observable
//            .combineLatest(viewWillAppear, checkParameter.filterNil())
//            .map { model.makeDangiParameter(lat: $1.coordinate.latitude, lon: $1.coordinate.longitude) }
//            .flatMapLatest(model.getDangi)
//            .asObservable()
//            .share()
        
        let forecastWeather = self.loactionData
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
    
        self.push = tappedNext
            .map { _ in
                let nextViewCon = UIViewController()
                nextViewCon.title = "다음 뷰 컨트롤러에염!"
                nextViewCon.view.backgroundColor = .white
                nextViewCon.modalPresentationStyle = .fullScreen
                return nextViewCon
            }
            .asDriver(onErrorDriveWith: .empty())
        
        let waatherResult = self.loactionData
            .filterNil()
            .map {
                model.makeSpaceParameter(lat: $0.coordinate.latitude, lon: $0.coordinate.longitude)
            }
            .flatMapLatest(model.getForecast)
            .debug("날씨 예보")
            .share()
        
        self.forecastWeatherData = waatherResult
            .map { result -> [ForecastItem] in
                guard case .success(let value) = result else {
                    return []
                }
                return model.parsForecastData(value: value.response.body.items.item)
            }
            .asDriver(onErrorDriveWith: .empty())
    }
    
    
}
