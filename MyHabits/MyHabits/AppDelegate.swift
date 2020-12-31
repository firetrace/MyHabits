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
        
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().tintColor = getColorStyle(style: .Magenta)
        
        UITabBar.appearance().tintColor = getColorStyle(style: .Magenta)
        
        return true
    }
}

