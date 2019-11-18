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
    
    //ViewModel -> View
    var currentWeatherData: Driver<[GribItem]> { get }
    var push: Driver<UIViewController> { get }
}

class TodayWeatherViewController: UIViewController {
    var disposeBag = DisposeBag()
    
    //UI
    var forecastView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    var temp = UILabel()
    var tappedViewControllerBtn = UIButton()
    
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
            .drive(self.rx.setData)
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
        
        
    }
    
    func attribute() {
        view.backgroundColor = .white
        title = "오늘의 날씨이이"
        
        let item = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        let item2 = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        navigationItem.rightBarButtonItem = item
        navigationItem.leftBarButtonItem = item2
        
        tappedViewControllerBtn.setTitle("다음 뷰 컨트롤러!", for: .normal)
        tappedViewControllerBtn.backgroundColor = .black
        
        forecastView.backgroundColor = .black
    }
    
    func layout() {
        view.addSubview(forecastView)
        view.addSubview(temp)
        view.addSubview(tappedViewControllerBtn)
        
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
        
        forecastView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(200)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(100)
            
        }
    }
}

extension Reactive where Base: TodayWeatherViewController {
    var setData: Binder<[GribItem]> {
        return Binder(base) { base, data in
            base.temp.text = "\(data.first!.category)"
        }
    }
}
