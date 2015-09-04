//
//  ViewController.swift
//  Osiris Team Checker
//
//  Created by JOSH HENDERSHOT on 8/18/15.
//  Copyright © 2015 Joshua Hendershot. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    
    let apiKey = "1c2ea6161c2647d6a68b9ccfecf7898e"
    var systemID = 1
    var gamertag = ""
    var destinyMembershipId = ""
    
    @IBOutlet weak var systemToggle: UISegmentedControl!
    @IBOutlet weak var searchTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
    }
    
    func getMemberID(){
        let url = NSURL(string: "https://www.bungie.net/platform/destiny/SearchDestinyPlayer/\(systemID)/\(gamertag)")!
        
        //        let url = NSURL(string: "https://www.bungie.net/platform/destiny/\(systemID)/Stats/GetMembershipIdByDisplayName/\(gamertag)")!
        let request = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "<X-API-Key")
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            
            if let urlContent = data {
                
                do {
                    
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                    //                    print(jsonResult)
                    
                    if let userInfo = jsonResult as? NSDictionary {
                        if let userInfo2 = userInfo["Response"] as? NSArray {
                            if let userInfo3 = userInfo2[0] as? NSDictionary {
                                if let userName = userInfo3["displayName"] as? String {
                                    print(userName)
                                    //                    print(jsonResult["Response"]! as! String)
                                    //                    self.destinyMembershipId = jsonResult["Response"]! as! String
                                    //                    self.charCheck()
                                    
                                    
                                }
                            }
                        }
                    }
                } catch {
                    
                    print("JSON serialization failed")
                    
                }
                
                
            }
            
            
        }
        
        task.resume()
        
    }
    func charCheck (){
        
        let url = NSURL(string: "https://www.bungie.net/platform/destiny/\(systemID)/Account/\(destinyMembershipId)/")!
        let request = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "<X-API-Key")
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            
            if let urlContent = data {
                
                do {
                    
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                    
                    print(jsonResult)
                    
                } catch {
                    
                    print("JSON serialization failed")
                    
                }
                
                
            }
            
            
        }
        
        task.resume()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        if textField != "" {
            gamertag = textField.text!
            getMemberID()
        }
        self.view.endEditing(true)
        return false
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        textFieldShouldReturn(searchTextfield)
    }
}

