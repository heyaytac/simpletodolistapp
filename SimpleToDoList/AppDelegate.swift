//
//  AppDelegate.swift
//  SimpleToDoList
//
//  Created by Privat on 10.09.24.
//

import UIKit
import Usercentrics

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let options = UsercentricsOptions(settingsId: "pP_c87KdAMJxes")
        UsercentricsCore.configure(options: options)
        return true
    }
}
