//
//  AppDelegate.swift
//  NeumorphicKitExamples
//
//  Created by Prashant Shrivastava on 12/06/20.
//  Copyright © 2020 CRED. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setRootViewController()
        return true
    }
        
    private func setRootViewController() {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = ViewController(nibName: "ViewController", bundle: nil)
        self.window?.makeKey()
    }
}

