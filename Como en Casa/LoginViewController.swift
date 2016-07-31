//
//  ViewController.swift
//  Como en Casa
//
//  Created by Rodolfo Castillo on 7/30/16.
//  Copyright © 2016 Rodolfo Castillo. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    var player: AVPlayer?
    
    @IBOutlet weak var btnFB: FBSDKLoginButton!
    @IBOutlet weak var btnNM: UIButton!
    @IBOutlet weak var fieldA: UITextField!
    @IBOutlet weak var fieldB: UITextField!
    
    var quitaELPUTOTECLADO: UITapGestureRecognizer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configVideo()
        btnFB.delegate = self
        
        self.quitaELPUTOTECLADO = UITapGestureRecognizer(target: self, action: #selector(self.QUITAELPUTOTECLADO(_:)))
        self.quitaELPUTOTECLADO.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(self.quitaELPUTOTECLADO)
        
        FBSDKLoginManager().logOut()
        self.view.bringSubviewToFront(btnFB)
        self.view.bringSubviewToFront(fieldA)
        self.view.bringSubviewToFront(fieldB)
        
        self.view.bringSubviewToFront(btnNM)
    }
    
    func configVideo(){
        let videoURL: NSURL = NSBundle.mainBundle().URLForResource("video", withExtension: "mov")!
        
        player = AVPlayer(URL: videoURL)
        player?.actionAtItemEnd = .None
        player?.muted = true
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayer.zPosition = -1
        
        playerLayer.frame = view.frame
        
        view.layer.addSublayer(playerLayer)
        
        player?.play()
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(LoginViewController.loopVideo),
                                                         name: AVPlayerItemDidPlayToEndTimeNotification,
                                                         object: nil)
    }
    
    func loopVideo() {
        player?.seekToTime(kCMTimeZero)
        player?.play()
    }
    

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if (result.isCancelled == false && error == nil ){
            let nv = self.storyboard?.instantiateViewControllerWithIdentifier("FoodMenuController")
            self.presentViewController(nv!, animated: true, completion: nil)
        }
    }
    
    @IBAction func enter(sender: AnyObject?){
        let nv = self.storyboard?.instantiateViewControllerWithIdentifier("FoodMenuController")
        self.presentViewController(nv!, animated: true, completion: nil)
    }
    
    func QUITAELPUTOTECLADO(sender: AnyObject){
        self.view.endEditing(true)
    }
    

}

