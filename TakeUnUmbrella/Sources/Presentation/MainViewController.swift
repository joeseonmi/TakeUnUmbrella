//
//  MainViewController.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/11/15.
//  Copyright © 2019 조선미. All rights reserved.
//

import UIKit

protocol MainViewBindable {
    
}

class MainViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
    }
    
    func bind(_ viewModel: MainViewBindable) {
        
    }
    
    func attribute() {
        view.backgroundColor = .white
    }
}
