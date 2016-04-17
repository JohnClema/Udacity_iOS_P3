//
//  AppDelegate.swift
//  OnTheMap
//
//  Created by John Clema on 16/03/2016.
//  Copyright © 2016 JohnClema. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        UILabel.appearance().font = UIFont(name: "Roboto-Regular", size: 17)


        // Override point for customization after application launch.
        return true
    }
}

