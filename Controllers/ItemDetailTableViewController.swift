//
//  ItemDetailTableViewController.swift
//  HomeInventory
//
//  Created by Hafeez on 1/29/16.
//  Copyright © 2016 Arshia. All rights reserved.
//

import UIKit

typealias CompletionHandler = (Item)->()

class ItemDetailTableViewController: UITableViewController {

    // Could be nil so keep it optional
    var item: Item?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var itemIDLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    var completionHandler: CompletionHandler?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if let item = item {
            nameLabel.text = item.name
            itemIDLabel.text = "\(item.itemID)"
            descriptionLabel.text = item.description
            valueLabel.text = "\(item.value)"
        }
        navigationItem.title = "Item Detail"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        completionHandler?(item!)
    }
    
    func done () {
        completionHandler?(item!)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Table view data source

    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "EditValueSegue" {
            let numVC = segue.destinationViewController as! NumericEntryViewController
            numVC.initValue = item!.value
            numVC.completionHandler = { amtval in
                self.item?.value = amtval // change model
                self.valueLabel.text = "\(amtval)"   // change value in label
            }
            
        }
    }
    

}
