//
//  AppDelegate.swift
//  swift-chatapp
//
//  Created by 高畑 孝輝 on 2016/05/14.
//  Copyright © 2016年 japan-alps. All rights reserved.
//

import UIKit
import SocketIOClientSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var socket : SocketIOClient!


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let url = NSURL(string: "http://ec2-54-199-182-211.ap-northeast-1.compute.amazonaws.com:3000")!
        socket = SocketIOClient(socketURL: url)
        socket.on("connect") {data in
            print("connected!")
            
            let raw_image = UIImage(named: "image.jpeg")!
            let png_image = UIImagePNGRepresentation(raw_image)
            let image = png_image!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
            self.socket.emit("user_from_client", "hello")
            
            let URLString = NSBundle.mainBundle().pathForResource("movie", ofType: "m4v")!
            let URL : NSURL = NSURL.fileURLWithPath(URLString)
            let raw_video = NSData(contentsOfURL: URL)
            let video = raw_video!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
            
            print(image)
            
            self.socket.emit("img_from_client",image)
            self.socket.emit("movie_from_client",video)
        }
        
        socket.on("disconnect"){ data in
            print("disconnected!")
        }
        
        socket.on("user_from_server"){ (data,ack) in
            print(data)
        }
        
        socket.connect()
        
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

