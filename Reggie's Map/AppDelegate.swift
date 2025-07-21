//
//  AppDelegate.swift
//  Reggie's Map
//
//  Created by user282482 on 7/18/25.
//

import UIKit
import GooglePlaces

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        GMSPlacesClient.provideAPIKey("AIzaSyCAT")
        return true
    }
}
