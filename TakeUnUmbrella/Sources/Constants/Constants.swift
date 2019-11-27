//
//  Constants.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/11/15.
//  Copyright © 2019 조선미. All rights reserved.
//

import Foundation
import UIKit

//MARK: - 🐶 접근제한자 공부하기
public struct URLs {
    struct API {
        static let weatherAPI = "http://newsky2.kma.go.kr/service/SecndSrtpdFrcstInfoService2"
        static let dustApi = "http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty"
    }
}

public struct AppConstants {
    struct AppKey {
        static let appKey = "dZ3RPoI%2BsacOCxFGAQnh6tn8V3ypiYhPzmRG%2BIY9%2FPq1Xfscm1xJFiC4eimk5GY94zEuMgg8OHJGsusUREKUxg%3D%3D"
    }
    //MARK: - 🐶 익스텐션 사용시 수정해주기
    struct UserDefaultKey {
        static let widgetShareDataKey = "group.devjoe.TodayExtensionSharingDefaults"
        static let widgetThemeDataKey = "Theme"
        static let currentCoordinate = "currentCoordinate"
        static let baseDate = "BaseDate"
        static let baseTime = "BaseTime"
    }
}

public struct AppAttribute {
    struct AppColor {
        static let background = UIColor(red: 245/255, green: 251/255, blue: 255/255, alpha: 1)
        static let shadow = UIColor(red: 106/255, green: 152/255, blue: 203/255, alpha: 1)
        static let white = UIColor(red: 245/255, green: 251/255, blue: 255/255, alpha: 1)
        static let gray01 = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        static let lightBlueGray = UIColor(red: 143/255, green: 160/255, blue: 179/255, alpha: 1)
        static let darkBlueGray = UIColor(red: 50/255, green: 63/255, blue: 78/255, alpha: 1)
    }
}

extension String {
    func doubleToInt() -> String {
        guard let double = Double(self) else { return "" }
        return "\(Int(double))"
    }
    func doubleRoundedToInt() -> String {
        guard let double = Double(self) else { return "" }
        return "\(Int(double.rounded()))"
    }
}

