//
//  AppDelegate.swift
//  MyHabits
//
//  Created by Александр Глазков on 18.12.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)        
        window?.rootViewController = NavigationViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
}

