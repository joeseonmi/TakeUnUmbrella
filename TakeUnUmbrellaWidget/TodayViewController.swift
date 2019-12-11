//
//  TodayViewController.swift
//  TakeUnUmbrellaWidget
//
//  Created by 조선미 on 2019/12/11.
//  Copyright © 2019 조선미. All rights reserved.
//

import UIKit
import NotificationCenter
import SnapKit


class TodayViewController: UIViewController, NCWidgetProviding {
    
    let titleLabel = UILabel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
    private func attribute() {
        titleLabel.text = "우오아아아아앙"
    }
    
    private func layout() {
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
