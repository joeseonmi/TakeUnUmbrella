//
//  NoticeViewController.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/12/10.
//  Copyright © 2019 조선미. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol NoticeBindable {
    
}

class NoticeViewController: UIViewController {
    var disposeBag = DisposeBag()

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
    
    func bind(_ viewModel: NoticeBindable) {
        
    }
    
    private func attribute() {
        view.backgroundColor = .white
    }
    
    private func layout() {
        
    }
}
