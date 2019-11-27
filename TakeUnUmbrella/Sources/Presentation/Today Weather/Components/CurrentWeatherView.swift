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
    
    private func attribute() {
        rainTitleLabel.text = "강수량(mm)"
        rehTItleLabel.text = "습도(%)"
        windTitleLabel.text = "바람(m/s)"
        rainLabel.text = "16"
        rehLabel.text = "16"
        windLabel.text = "16"
        rainTitleLabel.textAlignment = .center
        rehTItleLabel.textAlignment = .center
        windTitleLabel.textAlignment = .center
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
        tempLabel.text = "15"
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
            $0.top.equalTo(tempLabel.snp.bottom).offset(-6)
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
        rainTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.left.right.equalToSuperview()
        }
        rainLabel.snp.makeConstraints {
            $0.top.equalTo(rainTitleLabel.snp.bottom).offset(8)
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        rehTItleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.left.right.equalToSuperview()
        }
        rehLabel.snp.makeConstraints {
            $0.top.equalTo(rehTItleLabel.snp.bottom).offset(8)
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        windTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.left.right.equalToSuperview()
        }
        windLabel.snp.makeConstraints {
            $0.top.equalTo(windTitleLabel.snp.bottom).offset(8)
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        
    }

}
