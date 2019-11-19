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
import SnapKit

protocol TodayWeatherViewBindable {
    //View -> ViewModel
    var viewWillAppear: PublishSubject<Void> { get }
    var tappedNext: PublishRelay<Void> { get }
    var willDisplayCell: PublishRelay<IndexPath> { get }
    
    //ViewModel -> View
    var currentWeatherData: Driver<[GribItem]> { get }
    var forecastWeatherData: Driver<[WeatherItem]> { get }
//    var cellData: Driver<[WeatherItem]> { get }
    var push: Driver<UIViewController> { get }
//    var reloadList: Signal<Void> { get }
}

class TodayWeatherViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    var disposeBag = DisposeBag()
    
    //UI
    var forecastViewCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    var temp = UILabel()
    var tappedViewControllerBtn = UIButton()
    var scrollView = UIScrollView()
    var stackView = UIStackView()
    
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
        
        viewModel.currentWeatherData
            .drive(self.rx.setCurrentlyData)
            .disposed(by: disposeBag)
        
        forecastViewCollectionView.rx.willDisplayCell
            .map { $0.at }
            .bind(to: viewModel.willDisplayCell)
            .disposed(by: disposeBag)
        
        //버튼을 눌렀을때
        tappedViewControllerBtn.rx.tap
            .map { _ in }
            .bind(to: viewModel.tappedNext)
            .disposed(by: disposeBag)
        
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
    }
    
    func attribute() {
        view.backgroundColor = .white
        title = "오늘의 날씨이이"
        
        let item2 = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        navigationItem.leftBarButtonItem = item2
        
        tappedViewControllerBtn.setTitle("다음 뷰 컨트롤러!", for: .normal)
        tappedViewControllerBtn.backgroundColor = .black
        
        forecastViewCollectionView.backgroundColor = .yellow
        forecastViewCollectionView.register(ForecastCell.self, forCellWithReuseIdentifier: String(describing: ForecastCell.self))
        forecastViewCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        let flowLayout = UICollectionViewFlowLayout()
        forecastViewCollectionView.setCollectionViewLayout(flowLayout, animated: true)
        
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        
    }
    
    func layout() {
        view.addSubview(forecastViewCollectionView)
        view.addSubview(temp)
        view.addSubview(tappedViewControllerBtn)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        temp.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        
        tappedViewControllerBtn.snp.makeConstraints {
            $0.top.equalToSuperview().offset(200)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(56)
        }
        
        scrollView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-200)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(100)
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
            base.temp.text = "\(data.first!.category)"
        }
    }
}
