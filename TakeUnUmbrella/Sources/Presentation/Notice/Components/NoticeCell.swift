//
//  NoticeCell.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/12/11.
//  Copyright © 2019 조선미. All rights reserved.
//

import UIKit

class NoticeCell: UITableViewCell {
    
    var title = UILabel().subTitle
    var date = UILabel().caption

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ data: Notice) {
        title.text = data.title
        date.text = "\(data.createdAt.dateValue())"
    }
    
    private func attribute() {
        title.textColor = AppAttribute.AppColor.darkBlueGray
        date.textColor = AppAttribute.AppColor.lightBlueGray
        title.textAlignment = .left
        date.textAlignment = .left
    }
    private func layout() {
        addSubview(title)
        addSubview(date)
        
        title.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
        date.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(8)
            $0.left.right.equalTo(title)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
       
}
