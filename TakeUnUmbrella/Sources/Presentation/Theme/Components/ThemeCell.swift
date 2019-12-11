//
//  ThemeCell.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/12/11.
//  Copyright © 2019 조선미. All rights reserved.
//

import UIKit

class ThemeCell: UITableViewCell {
    
    var title = UILabel().subTitle
    var subTitle = UILabel().body
    var themeImage = UIImageView()
    var check = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ data: Theme) {
        themeImage.image = data.themeImage
        title.text = data.title
        subTitle.text = data.subTitle
        check.image = data.isSelected ?  #imageLiteral(resourceName: "RainSnow") :  #imageLiteral(resourceName: "Sunny")
    }
    
    private func attribute() {
        title.textColor = AppAttribute.AppColor.darkBlueGray
        subTitle.textColor = AppAttribute.AppColor.lightBlueGray
        title.textAlignment = .left
        subTitle.textAlignment = .left
    }
    private func layout() {
        addSubview(title)
        addSubview(subTitle)
        addSubview(themeImage)
        addSubview(check)
        
        themeImage.snp.makeConstraints {
            $0.width.height.equalTo(48)
            $0.top.leading.equalToSuperview().offset(16)
        }
        
        check.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.right.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
        }
        
        title.snp.makeConstraints {
            $0.left.equalTo(themeImage.snp.right).offset(16)
            $0.bottom.equalTo(themeImage.snp.centerY).offset(4)
            $0.right.equalTo(check.snp.left).offset(-8)
        }
        subTitle.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(4)
            $0.left.right.equalTo(title)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
    
}
