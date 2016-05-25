//
//  ViewController.swift
//  swift-chatapp
//
//  Created by 高畑 孝輝 on 2016/05/14.
//  Copyright © 2016年 japan-alps. All rights reserved.
//

import UIKit
import SocketIOClientSwift

class ViewController: UIViewController {
    var socket : SocketIOClient!

    @IBAction func pushJSONButton(sender: AnyObject) {
        let dict : [String: AnyObject] = [
            "name" : "hello",
            "desc" : "hello"
        ]
        
        self.socket.emit("json_from_client", dict)
    }
    
    @IBAction func pushImageButton(sender: AnyObject) {
        let raw_image = UIImage(named: "image.jpeg")!
        let png_image = UIImagePNGRepresentation(raw_image)
        let image = png_image!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        
        self.socket.emit("img_from_client",image)
    }
    
    @IBAction func pushVideoButton(sender: AnyObject) {
        let URLString = NSBundle.mainBundle().pathForResource("movie", ofType: "m4v")!
        let URL : NSURL = NSURL.fileURLWithPath(URLString)
        let raw_video = NSData(contentsOfURL: URL)
        let video = raw_video!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        
        self.socket.emit("movie_from_client",video)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        socket = appDelegate.socket as SocketIOClient
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

