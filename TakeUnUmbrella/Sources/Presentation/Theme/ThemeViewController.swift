//
//  ThemeViewController.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/12/11.
//  Copyright © 2019 조선미. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import RxAppState

protocol ThemeViewBindable {
    var viewWillAppear: PublishSubject<Void> { get }
}

class ThemeViewController: UIViewController {
    
    var tableView = UITableView()
    
    var themes: [Theme] = [
        Theme(title: "우상챙기개", subTitle: "댕댕이와 함께하는 날씨예보", themeImage: #imageLiteral(resourceName: "Moon"), isSelected: true),
        Theme(title: "우상챙겼냥", subTitle: "냥냥이와 함께하는 날씨예보", themeImage: #imageLiteral(resourceName: "Moon"), isSelected: false)
        ]

    init() {
        super.init(nibName: nil, bundle: nil)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: ThemeViewBindable) {
        let theme = Observable.of(themes)
        theme.bind(to: tableView.rx.items) { tv, row, data -> UITableViewCell in
            let index = IndexPath(row: row, section: 0)
            let cell = tv.dequeueReusableCell(withIdentifier: String(describing: ThemeCell.self), for: index) as! ThemeCell
            cell.configureCell(data)
            return cell
        }
    }

    private func attribute() {
        title = "🎨 테마"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(ThemeCell.self, forCellReuseIdentifier: String(describing: ThemeCell.self))
    }
    private func layout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.width.height.equalToSuperview()
        }
        
    }
}
