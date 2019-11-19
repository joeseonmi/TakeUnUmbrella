//
//  ForecastCell.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/11/16.
//  Copyright © 2019 조선미. All rights reserved.
//

import UIKit

import SnapKit

class ForecastCell: UICollectionViewCell {
    
    let value = UILabel()
    let categoty = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        attribute()
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(data: WeatherItem) {
        value.text = data.fcstValue
        categoty.text = data.category
    }
    
    private func attribute() {
        value.textAlignment = .center
        categoty.textAlignment = .center
    }
    
    private func layout() {
        addSubview(value)
        addSubview(categoty)
        
        value.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.equalToSuperview().offset(8)
            $0.right.equalToSuperview().offset(-8)
        }
        
        categoty.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.left.equalToSuperview().offset(8)
            $0.right.equalToSuperview().offset(-8)
            $0.top.equalTo(value.snp.bottom).offset(8)
        }
    }
}
