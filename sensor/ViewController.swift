import UIKit
import Alamofire

class ViewController: UIViewController {
    
    // Connection with interface builder
    
    //daifuku----------------------------
    var nicoTitle = NSString()
    var nicoUrl = NSString()
    var newurl = ""
    //----------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        //daifuku--------------------------------------------
        
        let url = "http://api.search.nicovideo.jp/api/v2/video/contents/search?q=%E3%83%89%E3%83%AF%E3%83%B3%E3%82%B4&targets=title&fields=contentId,title,viewCounter&filters[viewCounter][gte]=10000&_sort=-viewCounter&_offset=0&_limit=3&_context=apiguide"
        Alamofire.request(.GET,url).responseJSON{
            
            response in
            
            if response.result.isSuccess{
                
                let jsonDic = response.result.value as! NSDictionary
                
                let responseData = jsonDic["data"] as! NSArray
                
                self.nicoTitle = responseData[1]["title"] as! NSString
                self.nicoUrl = responseData[1]["contentId"] as! NSString
                
                NSLog("\(self.nicoTitle)")
                NSLog("\(self.nicoUrl)")
                
                
                
                
                
            }
            
        }
        
        //--------------------------------------------

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //daifuku-----------------------------------------------------------------
    @IBOutlet var label: UILabel!
    var url:String!
    
    @IBAction func opButton(sender: AnyObject) {
        label.text = self.nicoTitle as? String
        url = self.nicoUrl as? String
        NSLog(url)
        var url2:String! = "http://nico.ms/"
        var url3:String!
        url3 = url2 + url
        NSLog(url3)
        newurl = url3
        performSegueWithIdentifier("toWebView", sender: self)
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var wvc = segue.destinationViewController as! PushViewController
        wvc.newurl = newurl
    }
}
