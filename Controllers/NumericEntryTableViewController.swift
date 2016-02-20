//
//  NumericEntryTableViewController.swift
//  HomeInventory
//
//  Created by Hafeez on 1/29/16.
//  Copyright © 2016 Arshia. All rights reserved.
//

import UIKit

// closure function
typealias entryHandler = (Int)->()

class NumericEntryViewController: UIViewController {

    var completionHandler: entryHandler?
    
    var initValue: Int?
    
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if let initValue = initValue {
            textField.text = "\(initValue)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // changing value of item
        // first set a default
        var amountValue = 1
        if let valueString = textField.text {
            if let valueStringUnwrapped = Int(valueString)
            {
                // if I was passed a new value
                amountValue = valueStringUnwrapped
            }
        }
        completionHandler?(amountValue)
        
    }
    
        
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
