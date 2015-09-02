//
//  ViewController.swift
//  Osiris Team Checker
//
//  Created by JOSH HENDERSHOT on 8/18/15.
//  Copyright © 2015 Joshua Hendershot. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var systemToggle: UISegmentedControl!
    @IBOutlet weak var searchTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        self.view.endEditing(true)
        return false
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        textFieldShouldReturn(searchTextfield)
    }
}

