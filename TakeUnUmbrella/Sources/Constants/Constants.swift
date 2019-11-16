//
//  Constants.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/11/15.
//  Copyright © 2019 조선미. All rights reserved.
//

import Foundation


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
    }
}

