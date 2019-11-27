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
    var viewWillAppear: PublishSubject<Void> { get }
    var tappedNext: PublishRelay<Void> { get }
    var willDisplayCell: PublishRelay<IndexPath> { get }
    var loactionData: PublishSubject<CLLocation?> { get }
    
    //ViewModel -> View
    var currentWeatherData: Driver<[ForecastItem]> { get }
    var forecastWeatherData: Driver<[ForecastItem]> { get }
//    var cellData: Driver<[WeatherItem]> { get }
    var push: Driver<UIViewController> { get }
//    var reloadList: Signal<Void> { get }
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
    
        self.rx.viewWillAppear
            .map { _ in Void() }
            .bind(to: viewModel.viewWillAppear)
            .disposed(by: disposeBag)
        
//        viewModel.currentWeatherData
//            .drive(self.rx.setCurrentlyData)
//            .disposed(by: disposeBag)
        
//        forecastViewCollectionView.rx.willDisplayCell
//            .map { $0.at }
//            .bind(to: viewModel.willDisplayCell)
//            .disposed(by: disposeBag)
//
//        //버튼을 눌렀을때
//        tappedViewControllerBtn.rx.tap
//            .map { _ in }
//            .bind(to: viewModel.tappedNext)
//            .disposed(by: disposeBag)
        
        viewModel.push.drive(onNext: { vc in
            //MARK: 🐶 Rx에 self.rx.push~가 없따
            return self.present(vc, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        viewModel.forecastWeatherData
            .drive(onNext: { [weak self] data in
                data.forEach { [weak self] item in
                    let itemView = ForecastView()
                    itemView.configureView(data: item)
                    self?.stackView.addArrangedSubview(itemView)
                }
            })
            //MARK: 🐶 이 드라이브 코드의 정체는 무엇인지 모르겠음..@.@
//            .drive(forecastViewCollectionView.rx.items) { cv, row, data in
//                let index = IndexPath(row: row, section: 0)
//                let cell = cv.dequeueReusableCell(withReuseIdentifier: String(describing: ForecastCell.self), for: index) as! ForecastCell
//                cell.configureCell(data: data)
//                return cell
//        }
        .disposed(by: disposeBag)
        
//        viewModel.reloadList
//            .emit(onNext: { [weak self] _ in
//                self?.forecastViewCollectionView.reloadData()
//            })
//            .disposed(by: disposeBag)
        
        viewModel.currentWeatherData.drive(onNext: { items in
            print("현재 날씨: ", items)
            })
            .disposed(by: disposeBag)
        location.requestWhenInUseAuthorization()
        location.startUpdatingLocation()
        location.rx
            .placemark
            .subscribe(onNext: { place in
                guard let name = place.country else { return }
                print(name)
            })
            .disposed(by: disposeBag)
        
        location.rx
            .location
            .bind(to: viewModel.loactionData)
            .disposed(by: disposeBag)
        
    }
    
    func attribute() {
        view.backgroundColor = AppAttribute.AppColor.background
        menu.setImage(#imageLiteral(resourceName: "Menu"), for: .normal)
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.backgroundColor = .black
        stackView.distribution = .fillEqually
        locationNameLabel.text = "서울시 금천구"
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
            $0.top.equalToSuperview().offset(24)
            $0.left.equalToSuperview().offset(8)
        }
        
        locationNameLabel.snp.makeConstraints {
            $0.top.equalTo(menu.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(16)
        }
        
        animationView.snp.makeConstraints {
            $0.top.equalTo(locationNameLabel.snp.bottom).offset(16)
            $0.bottom.equalTo(currentWeatherView.snp.top).offset(-16)
            $0.left.right.equalToSuperview()
        }
        
        currentWeatherView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(100)
            $0.bottom.equalTo(scrollView.snp.top).offset(-48)
        }

        scrollView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
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
    var setCurrentlyData: Binder<[GribItem]> {
        return Binder(base) { base, data in
//            base.temp.text = "\(data.first!.category)"
        }
    }
}

//오늘의 최저, 최고 기온은 2시 데이터를 날짜로 확인, 저장해두고 있을 경우 네트워킹 안하고, 없으면 네트워킹 해주기
