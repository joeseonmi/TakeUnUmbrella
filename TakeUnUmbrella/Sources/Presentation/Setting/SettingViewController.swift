//
//  SettingViewController.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/12/10.
//  Copyright © 2019 조선미. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol SettingViewBindable {
    //View -> ViewModel
    var tappedCell: PublishRelay<IndexPath> { get }

    //ViewModel -> View
    var push: Driver<UIViewController> { get }
}

class SettingViewController: UIViewController {
    var disposebag = DisposeBag()
   
    //UI
    let tableView = UITableView()
    
    //Menu
    let menuItems = ["🎙 알려드립니다",
                     "🎨 테마",
                     "📱 배경화면",
                     "🕵🏻‍♀️ Contact"]

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
    
    func bind(viewModel: SettingViewBindable) {
        self.disposebag = DisposeBag()
        
        let menu = Observable.of(menuItems)
        menu.bind(to: tableView.rx.items) { tv, row, data in
            let index = IndexPath(row: row, section: 0)
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            cell.textLabel?.text = data
            return cell
        }
        .disposed(by: disposebag)
        
        tableView.rx.itemSelected
            .bind(to: viewModel.tappedCell)
            .disposed(by: disposebag)
            
        
        viewModel.push.drive(onNext: { [weak self] vc in
            self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposebag)
    }
    
    func attribute() {
        title = "Setting"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isHidden = false
       
        tableView.backgroundView = UIView()
        tableView.backgroundView?.isHidden = true
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 90
    }
    
    func layout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.width.height.equalToSuperview()
        }
    }

}
