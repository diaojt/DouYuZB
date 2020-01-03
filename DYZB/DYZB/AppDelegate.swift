//
//  AppDelegate.swift
//  DYZB
//
//  Created by Smy_D on 2020/1/2.
//  Copyright © 2020 Smy_D. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        UITabBar.appearance().tintColor = UIColor.orange
        
        return true
    }

}

