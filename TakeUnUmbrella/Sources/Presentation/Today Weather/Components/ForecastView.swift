//
//  ForecastView.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/11/19.
//  Copyright © 2019 조선미. All rights reserved.
//

import UIKit

class ForecastView: UIView {
    
    private var timeLabel = UILabel().body
    private var underLine = UIView()
    private var weatherIcon = UIImageView()
    private var forecastBG = baseView()
    private var temperLabel = UILabel().number03
    private var rainIcon = UIImageView()
    private var rainPer = UILabel().number05

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(data: ForecastItem) {
        timeLabel.text = "\(data.forecastTime)"
        temperLabel.text = data.temperature.doubleToInt()
        rainPer.text = data.rainfallPercent.doubleToInt() + "%"
        weatherIcon.image = data.weatherIcon()
    }
    
    private func attribute() {
        timeLabel.textColor = AppAttribute.AppColor.gray01
        temperLabel.textColor = AppAttribute.AppColor.gray01
        temperLabel.textAlignment = .center
        rainPer.textColor = AppAttribute.AppColor.lightBlueGray
        rainPer.textAlignment = .center
        rainIcon.image = #imageLiteral(resourceName: "Rain")
        weatherIcon.contentMode = .scaleAspectFit
        underLine.backgroundColor = AppAttribute.AppColor.lightBlueGray
    }
    
    private func layout() {
        let rainContainer = UIView()
        rainContainer.backgroundColor = .yellow
        addSubview(timeLabel)
        addSubview(underLine)
        addSubview(forecastBG)
        addSubview(weatherIcon)
        forecastBG.addSubview(temperLabel)
        forecastBG.addSubview(rainContainer)
        rainContainer.addSubview(rainIcon)
        rainContainer.addSubview(rainPer)
        
        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        underLine.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(2)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(timeLabel)
            $0.height.equalTo(0.5)
        }
    
        forecastBG.snp.makeConstraints {
            $0.top.equalTo(weatherIcon.snp.centerY)
            $0.width.equalTo(weatherIcon).offset(16)
            $0.left.right.equalToSuperview()
        }
        
        weatherIcon.snp.makeConstraints {
            $0.top.equalTo(underLine.snp.bottom).offset(6)
            $0.width.height.equalTo(60)
            $0.centerX.equalTo(forecastBG.snp.centerX)
        }
        
        temperLabel.snp.makeConstraints {
            $0.top.equalTo(weatherIcon.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(8)
            $0.right.equalToSuperview().offset(-8)
        }
        
        rainContainer.snp.makeConstraints {
            $0.top.equalTo(temperLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-32)
        }
        
        rainIcon.snp.makeConstraints {
            $0.width.height.equalTo(12)
            $0.left.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        rainPer.snp.makeConstraints {
            $0.centerY.equalTo(rainIcon)
            $0.left.equalTo(rainIcon.snp.right).offset(2)
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

}
