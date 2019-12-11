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
import RxAppState

protocol NoticeBindable {
    var viewWillAppear: PublishRelay<Void> { get }
    var loadNotices: Driver<[Notice]> { get }
    var selectedItem: PublishRelay<IndexPath> { get }
}

class NoticeViewController: UIViewController {
    var disposeBag = DisposeBag()

    var tableView = UITableView()
    
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
        self.disposeBag = DisposeBag()
        
        self.rx.viewWillAppear
            .map { _ in }
            .bind(to: viewModel.viewWillAppear)
            .disposed(by: disposeBag)
        
        viewModel.loadNotices
            .drive(tableView.rx.items) { tv, row, notice -> UITableViewCell in
                let index = IndexPath(row: row, section: 0)
                let cell = tv.dequeueReusableCell(withIdentifier: String(describing: NoticeCell.self), for: index) as! NoticeCell
                cell.configureCell(notice)
                return cell
        }
        .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .bind(to: viewModel.selectedItem)
            .disposed(by: disposeBag)
        
    }
    
    private func attribute() {
        view.backgroundColor = .white
        title = "🎙 알려드립니다"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(NoticeCell.self, forCellReuseIdentifier: String(describing: NoticeCell.self))
    }
    
    private func layout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.width.height.equalToSuperview()
        }
    }
}
