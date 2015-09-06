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
    @IBOutlet weak var systemToggle: UISegmentedControl!
    @IBOutlet weak var searchTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        if textField != "" {
            gamertag = textField.text!.stringByReplacingOccurrencesOfString(" ", withString: "")
            DataManager.getMemberID()
        }
        self.view.endEditing(true)
        return false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        textFieldShouldReturn(searchTextfield)
    }
}

