//
//  DownloadBGViewController.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/12/11.
//  Copyright © 2019 조선미. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import RxAppState

protocol DownloadBGViewBindable {
    var viewWillAppear: PublishSubject<Void> { get }
    var loadBGs: Driver<[BGImage]> { get }
}

class DownloadBGViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func bind(_ viewModel: DownloadBGViewBindable) {
        self.disposeBag = DisposeBag()
      
        self.rx.viewWillAppear
            .map { _ in }
            .bind(to: viewModel.viewWillAppear)
            .disposed(by: disposeBag)
        
        viewModel.loadBGs.drive(onNext: { data in
            print(data)
        })
    }
    
    private func attribute() {
        view.backgroundColor = .white
        title = "📱 배경화면"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func layout() {
        
    }
}
