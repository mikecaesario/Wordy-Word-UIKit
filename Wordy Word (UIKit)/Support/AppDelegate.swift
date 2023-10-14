//
//  AppDelegate.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 01/05/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        registerDefaults()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) { }
    
    func registerDefaults() {
        
        let defaults = UserDefaults.standard
        let defaultValue: [String: Any] = [UserDefaultsEnum.maxHistoryDataLimit: 5]
        defaults.register(defaults: defaultValue)
    }
}

