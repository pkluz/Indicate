//
//  AppDelegate.swift
//  Indicate Example
//
//  Created by Philip Kluz on 2021-03-07.
//  Copyright © 2021 Philip Kluz. All rights reserved.
//

import UIKit

@main
public class AppDelegate: UIResponder, UIApplicationDelegate {
     
    // MARK: UIApplicationDelegate
    
    public var window: UIWindow?

    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = MainViewController()
        self.window = window
        window.makeKeyAndVisible()
        return true
    }
}

