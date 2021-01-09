//
//  AppDelegate.swift
//  SynthExamples
//
//  Copyright 2020 Dreamplug Technologies Private Limited
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
        
        let rootVC = ViewController(nibName: "ViewController", bundle: nil)
        let navController = UINavigationController(rootViewController: rootVC)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navController
        self.window?.makeKey()
    }
}

