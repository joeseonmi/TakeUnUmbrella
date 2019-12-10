//
//  TodayWeatherViewController.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/11/15.
//  Copyright © 2019 조선미. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import RxAppState
import RxCoreLocation
import SnapKit
import CoreLocation


protocol TodayWeatherViewBindable {
    //View -> ViewModel
    var viewWillAppear: PublishSubject<CLLocation?> { get }
    var tappedMenu: PublishRelay<Void> { get }
    
    //ViewModel -> View
    var currentWeatherData: Driver<[ForecastItem]> { get }
    var forecastWeatherData: Driver<[[ForecastItem]]> { get }
    var maxMinTempData: Driver<MaxMinToday> { get }
    var push: Driver<UIViewController> { get }
}

class TodayWeatherViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    var disposeBag = DisposeBag()
    
    //UI - 상단 메뉴 및 지역이름
    var menu = UIButton()
    var locationNameLabel = UILabel().title01
    
    //UI - 상단 날씨 이미지
    var animationView = AnimationWeatherView()
    
    //UI - 중단 현재 날씨
    var currentWeatherView = CurrentWeatherView()
    
    //UI - 하단 예보 ScrollView
    var scrollView = UIScrollView()
    var stackView = UIStackView()
    let location = CLLocationManager()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func bind(_ viewModel: TodayWeatherViewBindable) {
        self.disposeBag = DisposeBag()
    
        location.requestWhenInUseAuthorization()
        location.startUpdatingLocation()
        location.rx
            .placemark
            .subscribe(onNext: { [weak self] place in
                guard let name = place.locality, let sub = place.subLocality else { return }
                self?.locationNameLabel.text = name + " " + sub
            })
            .disposed(by: disposeBag)

        self.rx.viewWillAppear
            .map { [weak self] _ in
                return self?.location.location
            }
            .bind(to: viewModel.viewWillAppear)
            .disposed(by: disposeBag)
        
        menu.rx.tap.map { _ in }
            .bind(to: viewModel.tappedMenu)
            .disposed(by: disposeBag)
       
        viewModel.push.drive(onNext: { vc in
            //MARK: 🐶 Rx에 self.rx.push~가 없따
            return self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.forecastWeatherData
            .drive(onNext: { [weak self] data in
                var index = 0
                for i in data {
                    i.forEach { [weak self] item in
                        let itemView = ForecastView()
                        itemView.configureView(data: item, forecastDate: index)
                        self?.stackView.addArrangedSubview(itemView)
                    }
                    index += 1
                }
            })
        .disposed(by: disposeBag)
        
        viewModel.currentWeatherData
            .drive(onNext: { [weak self] items in
            guard let current = items.first else { return }
            self?.currentWeatherView.configure(data: current)
            self?.animationView.configure(data: current)
            })
            .disposed(by: disposeBag)
        
        viewModel.maxMinTempData
            .drive(onNext: { [weak self] items in
                self?.currentWeatherView.configureMaxMinTemp(data: items)
            })
            .disposed(by: disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
    }
    
    func attribute() {
        view.backgroundColor = AppAttribute.AppColor.background
        menu.setImage(#imageLiteral(resourceName: "Menu"), for: .normal)
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.backgroundColor = .black
        stackView.distribution = .fillEqually
        locationNameLabel.textAlignment = .right
        locationNameLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    func layout() {
        view.addSubview(menu)
        view.addSubview(locationNameLabel)
        view.addSubview(animationView)
        view.addSubview(currentWeatherView)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        menu.snp.makeConstraints {
            $0.width.height.equalTo(45)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            $0.left.equalToSuperview().offset(8)
        }
        
        locationNameLabel.snp.makeConstraints {
            $0.left.equalTo(menu.snp.right).offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(16)
            $0.centerY.equalTo(menu)
        }
        
        animationView.snp.makeConstraints {
            $0.top.equalTo(locationNameLabel.snp.bottom).offset(32)
            $0.bottom.equalTo(currentWeatherView.snp.top).offset(-32)
            $0.left.right.equalToSuperview()
        }
        
        currentWeatherView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(100)
            $0.bottom.equalTo(scrollView.snp.top).offset(-32)
        }

        scrollView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(225)
        }
        
        stackView.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
    }
}

//MARK: 🐶 ??
extension Reactive where Base: TodayWeatherViewController {
    var setLocationName: Binder<(String, String)> {
        return Binder(base) { base, data in
            base.locationNameLabel.text = "\(data.0) \(data.1)"
        }
    }
}

//오늘의 최저, 최고 기온은 2시 데이터를 날짜로 확인, 저장해두고 있을 경우 네트워킹 안하고, 없으면 네트워킹 해주기
