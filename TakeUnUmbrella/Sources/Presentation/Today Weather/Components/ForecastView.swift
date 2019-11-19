//
//  ForecastView.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/11/19.
//  Copyright © 2019 조선미. All rights reserved.
//

import UIKit

class ForecastView: UIView {
    
    private var forecastBG = UIView()
    private var value = UILabel()
    private var category = UILabel()
    private var sun = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(data: WeatherItem) {
        self.value.text = "\(data.fcstDate)"
        self.category.text = data.category
    }
    
    private func attribute() {
        value.textColor = .blue
        category.textColor = .darkGray
        forecastBG.backgroundColor = .lightGray
        forecastBG.layer.cornerRadius = 16
        sun.backgroundColor = .yellow
    }
    
    private func layout() {
        addSubview(forecastBG)
        addSubview(sun)
        forecastBG.addSubview(value)
        forecastBG.addSubview(category)
    
        forecastBG.snp.makeConstraints {
            $0.top.equalTo(sun.snp.centerY)
            $0.bottom.equalToSuperview()
            $0.width.equalToSuperview()
            $0.left.equalToSuperview()
        }
        
        sun.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.width.height.equalTo(forecastBG.snp.width).multipliedBy(0.6)
            $0.centerX.equalTo(forecastBG.snp.centerX)
        }
        
        value.snp.makeConstraints {
            $0.top.equalTo(sun.snp.bottom).offset(24)
            $0.left.equalToSuperview().offset(8)
            $0.right.equalToSuperview().offset(-8)
        }
        
        category.snp.makeConstraints {
            $0.top.equalTo(value.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(8)
            $0.right.equalToSuperview().offset(-8)
            $0.bottom.equalToSuperview().offset(-24)
        }
    }

}
