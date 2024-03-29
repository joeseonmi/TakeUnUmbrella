//
//  AppDelegate.swift
//  TakeUnUmbrella
//
//  Created by 조선미 on 2019/11/15.
//  Copyright © 2019 조선미. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        // Override point for customization after application launch.
        self.window = UIWindow()
        let rootViewController = TodayWeatherViewController()
        let rootViewModel = TodayWeatherViewModel()
        let navigation = UINavigationController(rootViewController: rootViewController)
        rootViewController.bind(rootViewModel)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        return true
    }


}

