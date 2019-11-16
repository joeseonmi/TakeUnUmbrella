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
    var viewWillAppear: PublishSubject<Void> { get }
}

class TodayWeatherViewController: UIViewController {
    var disposeBag = DisposeBag()
    
    var forecastView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    var temp = UILabel()
    
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
        print("바인드 돌았음")
        self.disposeBag = DisposeBag()
        self.rx.viewWillAppear
            .map { _ in Void() }
            .bind(to: viewModel.viewWillAppear)
            .disposed(by: disposeBag)
    }
    
    func attribute() {
        view.backgroundColor = .white
        title = "오늘의 날씨이이"
        
        let item = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        let item2 = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        navigationItem.rightBarButtonItem = item
        navigationItem.leftBarButtonItem = item2
    }
    
    func layout() {
        view.addSubview(forecastView)
        view.addSubview(temp)
        
        temp.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
    }

}
