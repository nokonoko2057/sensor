//
//  PushViewController.swift
//  sensor
//
//  Created by yuki takei on 2015/11/28.
//  Copyright © 2015年 yuki takei. All rights reserved.
//

import CoreMotion
import UIKit


class PushViewController: UIViewController ,UIWebViewDelegate{

    
    @IBOutlet var acc_x: UILabel!
    @IBOutlet var acc_y: UILabel!
    @IBOutlet var acc_z: UILabel!
    @IBOutlet var countLabel:UILabel!
    var count:Int = 0
    
    //時間計測用の変数.
    var pushTime: Float = 0
    //時間表示用のラベル.
    var myLabel : UILabel!
    //タイマー.
    var timer : NSTimer!
    
        
    // create instance of MotionManager
    let motionManager: CMMotionManager = CMMotionManager()

    
    //daifuku---------------------------------------------------
    @IBOutlet weak var webview: UIWebView!
    var newurl = ""
    //-----------------------------------
    

    
//    var targetURL = "http://www.nicovideo.jp/"
   // var targetURL = "http://stackoverflow.com/questions/30720813/cfnetwork-sslhandshake-failed-ios-9"
    
    //http://stackoverflow.com/questions/30720813/cfnetwork-sslhandshake-failed-ios-9
    
    
    
    
   
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        //daifuku--------------------------------------------------
        let url = NSURL(string: newurl)
        let urlRequest = NSURLRequest(URL: url!)
        webview.loadRequest(urlRequest)
        
        //nknk-----------------------------------------------------------
         timer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: "onUpdate:", userInfo: nil, repeats: true)
        
        motionManager.deviceMotionUpdateInterval = 0.08 // 20Hz
        
        // Start motion data acquisition
        motionManager.startDeviceMotionUpdatesToQueue( NSOperationQueue.currentQueue()!, withHandler:{
            deviceManager, error in
            let accel: CMAcceleration = deviceManager!.userAcceleration
            
            self.acc_x.text = String(format: "x:%.2f", accel.x)
            
            self.acc_y.text = String(format: "y:%.2f", accel.y)
            self.acc_z.text = String(format: "z:%.2f", accel.z)
            
            if (accel.z < -0.1 && accel.x < 0.2 && accel.x > -0.2 && accel.y < 0.2 && accel.y > -0.2){
                self.count++
                NSLog("%d", self.count)
                self.countLabel.text = String(self.count)
                
                
            }
            
            
        })
        
    }
    
    func onUpdate(timer : NSTimer){
        
        pushTime += 0.05
        
        //桁数を指定して文字列を作る.
        let str = "Time:".stringByAppendingFormat("%.1f",pushTime)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    Pageがすべて読み込み終わった時呼ばれるデリゲートメソッド.
    */
    func webViewDidFinishLoad(webView: UIWebView) {
        print("webViewDidFinishLoad")
    }
    
    /*
    Pageがloadされ始めた時、呼ばれるデリゲートメソッド.
    */
    func webViewDidStartLoad(webView: UIWebView) {
        print("webViewDidStartLoad")
    }
    
    func didFailLoadWithError(){
        print("Error")
    }
    
    

    
    //---------------------------------------------------------------------
    

//    
//    func loadAddressURL() {
//        let requestURL = NSURL(string: targetURL)
//        let req = NSURLRequest(URL: requestURL!)
//        webview!.loadRequest(req)
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
