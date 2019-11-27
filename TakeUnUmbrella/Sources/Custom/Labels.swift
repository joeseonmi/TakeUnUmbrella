//
//  Labels.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/11/26.
//  Copyright © 2019 조선미. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    var title01: UILabel {
        textColor = AppAttribute.AppColor.darkBlueGray
        font = UIFont(name: "AppleSDGothicNeo-Regular", size: 24)
        return self
    }
    var body: UILabel {
        textColor = AppAttribute.AppColor.darkBlueGray
        font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)
        return self
    }
    var caption: UILabel {
        textColor = AppAttribute.AppColor.darkBlueGray
        font = UIFont(name: "AppleSDGothicNeo-Regular", size: 10)
        return self
    }
    
    var number01: UILabel {
        textColor = AppAttribute.AppColor.darkBlueGray
        font = UIFont(name: "AvenirNext-Medium", size: 48)
        return self
    }
    var number02: UILabel {
        textColor = AppAttribute.AppColor.darkBlueGray
        font = UIFont(name: "AvenirNext-Medium", size: 38)
        return self
    }
    var number03: UILabel {
        textColor = AppAttribute.AppColor.darkBlueGray
        font = UIFont(name: "AvenirNext-Regular", size: 28)
        return self
    }
    var number04: UILabel {
        textColor = AppAttribute.AppColor.darkBlueGray
        font = UIFont(name: "AvenirNext-Regular", size: 17)
        return self
    }
    var number05: UILabel {
        textColor = AppAttribute.AppColor.darkBlueGray
        font = UIFont(name: "AvenirNext-Regular", size: 12)
        return self
    }
}


/*
 AppleSDGothicNeo-Bold
 AppleSDGothicNeo-Light
 AppleSDGothicNeo-Medium
 AppleSDGothicNeo-Regular
 AppleSDGothicNeo-SemiBold
 AppleSDGothicNeo-Thin
 */
