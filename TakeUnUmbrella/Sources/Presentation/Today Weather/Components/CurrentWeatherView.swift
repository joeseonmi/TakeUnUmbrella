//
//  CurrentWeatherView.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/11/28.
//  Copyright © 2019 조선미. All rights reserved.
//

import UIKit

class CurrentWeatherView: UIView {

    private var currentTempBG = baseView()
    private var tempLabel = UILabel().number02
    private var maxminLabel = UILabel().number04
    
    private var currentWeatherBG = baseView()
    private var stackView = UIStackView()
    private var rainTitleLabel = UILabel().caption
    private var rehTItleLabel = UILabel().caption
    private var windTitleLabel = UILabel().caption
    private var windForceLabel = UILabel().caption
    private var rainLabel = UILabel().number03
    private var rehLabel = UILabel().number03
    private var windLabel = UILabel().number03
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: ForecastItem) {
        tempLabel.text = "\(data.temperature.doubleRoundedToInt())"
        rainLabel.text = "\(data.rainfallPercent.doubleToInt())"
        rehLabel.text = "\(data.humi.doubleToInt())"
        windLabel.text = "\(data.wind.doubleToInt())"
        windForceLabel.text = wind(value: data.wind.doubleToInt())
    }
    
    private func wind(value: String) -> String {
        guard let intValue = Int(value) else { return "" }
        if intValue < 4 {
            return "약함"
        } else if intValue >= 4 && intValue < 9 {
            return "약간 강함"
        } else if intValue >= 9 && intValue < 14 {
            return "강함"
        } else {
            return "매우 강함"
        }
    }
    
    private func attribute() {
        rainTitleLabel.text = "강수량(mm)"
        rehTItleLabel.text = "습도(%)"
        windTitleLabel.text = "바람(m/s)"
        rainTitleLabel.textAlignment = .center
        rehTItleLabel.textAlignment = .center
        windTitleLabel.textAlignment = .center
        windForceLabel.textColor = AppAttribute.AppColor.lightBlueGray
        windForceLabel.textAlignment = .center
        rainLabel.textAlignment = .center
        rehLabel.textAlignment = .center
        windLabel.textAlignment = .center
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        maxminLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        maxminLabel.text = "-1 / 15"
        maxminLabel.textAlignment = .center
        tempLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        tempLabel.textAlignment = .center
    }
    private func layout() {
        let rainView = UIView()
        let rehView = UIView()
        let windView = UIView()
        addSubview(currentWeatherBG)
        addSubview(currentTempBG)
        currentTempBG.addSubview(tempLabel)
        currentTempBG.addSubview(maxminLabel)
        currentWeatherBG.addSubview(stackView)
        rainView.addSubview(rainTitleLabel)
        rainView.addSubview(rainLabel)
        rehView.addSubview(rehTItleLabel)
        rehView.addSubview(rehLabel)
        windView.addSubview(windTitleLabel)
        windView.addSubview(windForceLabel)
        windView.addSubview(windLabel)
        stackView.addArrangedSubview(rainView)
        stackView.addArrangedSubview(rehView)
        stackView.addArrangedSubview(windView)
        
        currentTempBG.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalTo(currentWeatherBG.snp.left).offset(-12)
            $0.bottom.top.equalToSuperview()
            $0.width.height.equalTo(100)
        }
        
        tempLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.left.equalToSuperview().offset(8)
            $0.right.equalToSuperview().offset(-8)
        }
        maxminLabel.snp.makeConstraints {
            $0.top.equalTo(tempLabel.snp.bottom).offset(-4)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-16)
        }
        
        currentWeatherBG.snp.makeConstraints {
            $0.right.bottom.top.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.bottom.top.equalToSuperview()
        }
        
        //높이가 100이라고침
        windTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        
        windForceLabel.snp.makeConstraints {
            $0.top.equalTo(windLabel.snp.bottom).offset(-2)
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        
        windLabel.snp.makeConstraints {
            $0.top.equalTo(windTitleLabel.snp.bottom).offset(8)
            $0.left.right.equalToSuperview()
        }
        rainTitleLabel.snp.makeConstraints {
            $0.top.equalTo(windTitleLabel)
            $0.left.right.equalToSuperview()
        }
        rainLabel.snp.makeConstraints {
            $0.top.equalTo(rainTitleLabel.snp.bottom).offset(8)
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        rehTItleLabel.snp.makeConstraints {
            $0.top.equalTo(windTitleLabel)
            $0.left.right.equalToSuperview()
        }
        rehLabel.snp.makeConstraints {
            $0.top.equalTo(rehTItleLabel.snp.bottom).offset(8)
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
    }
}
