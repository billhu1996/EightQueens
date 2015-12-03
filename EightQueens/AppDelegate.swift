 //
//  AppDelegate.swift
//  EightQueens
//
//  Created by Bill Hu on 15/10/20.
//  Copyright © 2015年 Bill Hu. All rights reserved.
//
 // 我真诚地保证：
 
 // 我自己独立地完成了整个程序从分析、设计到编码的所有工作。
 // 如果在上述过程中，我遇到了什么困难而求教于人，那么，我将在程序实习报告中
 // 详细地列举我所遇到的问题，以及别人给我的提示。
 
 // 在此，我感谢 XXX, …, XXX对我的启发和帮助。下面的报告中，我还会具体地提到
 // 他们在各个方法对我的帮助。
 
 // 我的程序里中凡是引用到其他程序或文档之处，
 // 例如教材、课堂笔记、网上的源代码以及其他参考书上的代码段,
 // 我都已经在程序的注释里很清楚地注明了引用的出处。
 
 // 我从未没抄袭过别人的程序，也没有盗用别人的程序，
 // 不管是修改式的抄袭还是原封不动的抄袭。
 
 // 我编写这个程序，从来没有想过要去破坏或妨碍其他计算机系统的正常运转。
 
 // 胡博
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var launchShortcutItem: UIApplicationShortcutItem?
    var queens: Int?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        if #available(iOS 9.1, *) {
            launchShortcutItem = UIApplicationShortcutItem(type: "Count", localizedTitle: "八皇后", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(type: UIApplicationShortcutIconType.Task), userInfo: nil)
        } else {
            // Fallback on earlier versions
        }
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
    
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        guard let shrotcutItem = launchShortcutItem else { return }
        handledShortcutItem(shrotcutItem)
        completionHandler(true)
    }

    func handledShortcutItem(shortcutItem: UIApplicationShortcutItem) -> Bool {
        queens = 8;
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "eightQueens", object: nil, userInfo: nil))
        return true
    }

}

