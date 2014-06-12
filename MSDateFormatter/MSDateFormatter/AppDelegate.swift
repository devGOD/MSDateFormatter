//
//  AppDelegate.swift
//  MSDateFormatter
//
//  Created by Michael on 11/6/14.
//  Copyright (c) 2014 Michael Vu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        // Override point for customization after application launch.
        println("One minute ago:  \(1.minute.ago())")
        println("Two day from now:  \(2.days.fromNow())")
        println("One hour and ten minutes ago:  \((1.hour + 10.minutes).ago())")
        println("Two days from now:  \(1.day.fromNow() + 1.day.fromNow())")
        println("Five hours from now:  \(3.day.add(2.day).fromNow())")
        println("3 months ago:  \(4.months.subtract(1.month).ago())")
        println("Yesterday:  \(NSDate.yesterday())")
        println("Tomorrow:  \(NSDate.tomorrow())")
        println("3 months ago for NSDate:  \(NSDate.date().ago(3.months))")
        println("Time Ago:  \(NSDate.date().timeAgo())")
        println("Time Ago Short:  \(NSDate.date().timeAgoShort())")
        println("Time Ago Simple:  \(NSDate.date().timeAgoSimple())")
        println("Time Ago Long Level 2:  \(NSDate.date().timeAgoLong(level: 2))")
        println("Date Time Ago:  \(NSDate.date().dateTimeAgo())")
        println("Date Time Ago Short:  \(NSDate.date().dateTimeAgoShort())")
        println("Date Time Ago Long Level 2:  \(NSDate.date().dateTimeAgoLong(level: 2))")
        println("To Local:  \(NSDate.date().toLocal())")
        println("To Global:  \(NSDate.date().toGlobal())")
        println("Beginning Of Day:  \(NSDate.date().beginningOfDay())")
        println("End Of Day:  \(NSDate.date().endOfDay())")
        println("Beginning Of Week:  \(NSDate.date().beginningOfWeek())")
        println("End Of Week:  \(NSDate.date().endOfWeek())")
        println("Beginning Of Month:  \(NSDate.date().beginningOfMonth())")
        println("End Of Month:  \(NSDate.date().endOfMonth())")
        println("Beginning Of Year:  \(NSDate.date().beginningOfYear())")
        println("End Of Year:  \(NSDate.date().endOfYear())")
        var longFormat = "dd-MM-yyyy HH:mm:ss"
        println("Long Formatter:  \(NSDate.date().format(longFormat))")
        var shortFormat = "dd-MM-yyyy"
        println("Short Formatter:  \(NSDate.date().format(shortFormat))")
        println("Other Formatter:  \(NSDate.date().format(sdate: .FullStyle, stime: .NoStyle))")
        println("Add Date:  \(NSDate.date().add(1.day))")
        println("Subtract Date:  \(NSDate.date().subtract(1.day))")
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

