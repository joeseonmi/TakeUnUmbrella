//
//  AnimationWeatherView.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/11/28.
//  Copyright © 2019 조선미. All rights reserved.
//

import UIKit

class AnimationWeatherView: UIView {
    
    var skyBG = UIImageView()
    var animal = UIImageView()
    var skyIcon = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func attribute() {
        skyBG.image = #imageLiteral(resourceName: "NightBG")
        skyIcon.image = #imageLiteral(resourceName: "LessCloudySun")
        skyIcon.contentMode = .scaleAspectFit
        skyBG.contentMode = .scaleAspectFit
        animal.image = #imageLiteral(resourceName: "Dog")
        animal.contentMode = .scaleAspectFit
    }
    func layout() {
        addSubview(skyBG)
        addSubview(skyIcon)
        addSubview(animal)
        
        skyBG.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.equalTo(skyBG.snp.height)
        }
        
        skyIcon.snp.makeConstraints {
            $0.width.height.equalTo(skyBG.snp.height).multipliedBy(0.8)
            $0.left.equalTo(skyBG.snp.centerX).multipliedBy(0.85)
            $0.bottom.equalTo(skyBG.snp.centerY).multipliedBy(1.55)
        }
        
        animal.snp.makeConstraints {
            $0.width.height.equalTo(skyBG.snp.height).multipliedBy(1.15)
            $0.right.equalTo(skyBG.snp.centerX).multipliedBy(1.5)
            $0.top.equalTo(skyBG.snp.centerY).multipliedBy(0.3)
        }
    }
}
