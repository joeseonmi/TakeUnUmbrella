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

    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
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
    }
    
    private func layout() {
        addSubview(forecastBG)
        addSubview(value)
        addSubview(category)
        
        forecastBG.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(forecastBG.snp.width)
            
        }
        
        value.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.left.equalToSuperview().offset(8)
            $0.right.equalToSuperview().offset(-8)
        }
        
        category.snp.makeConstraints {
            $0.top.equalTo(value).offset(16)
            $0.left.equalToSuperview().offset(8)
            $0.right.equalToSuperview().offset(-8)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }

}
