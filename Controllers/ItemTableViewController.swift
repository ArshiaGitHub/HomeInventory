//
//  ItemTableViewController.swift
//  HomeInventory
//
//  Created by Hafeez on 1/29/16.
//  Copyright © 2016 Arshia. All rights reserved.
//

import UIKit

class ItemTableViewController: UITableViewController {

    // Array of items.  Implicitly unwrapped: optional, but we promise that it will always have a value that is not nil
    var items: [Item]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        
        // My inventory list
        // In a real program, would be something like:
        // items = getItemsFromDatabase() or
        // items = 
        //  getItemsFromCloudUsingURL(url:"https://myitems.example.com/items")
        
        items = [
            Item(name: "Item1", itemID: 1, description: "Table", image: "A01.jpg", thumb: "thumbA01.jpg", value: 300),
            Item(name: "Item2", itemID: 2, description: "Chair", image: "A02.jpg", thumb: "thumbA02.jpg", value: 100),
            Item(name: "Item3", itemID: 3, description: "Sofa", image: "A03.jpg", thumb: "thumbA03.jpg", value: 700),
            Item(name: "Item4", itemID: 4, description: "TV", image: "A04.jpg", thumb: "thumbA04.jpg", value: 900),
            Item(name: "Item5", itemID: 5, description: "PC", image: "A05.jpg", thumb: "thumbA05.jpg", value: 500)
        ]
        
        navigationItem.title = "Home Items"
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        navigationItem.rightBarButtonItem = editButtonItem()
        
        /* Another way to implement insert
        navigationItem.leftBarButtonItem =
        UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addItem")
        */

    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // there was a warning here to return a value, rmved it
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return items.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Configure the cell...
        let row = indexPath.row
        let item = items[row]

        let cell = tableView.dequeueReusableCellWithIdentifier("CellTypeItem", forIndexPath: indexPath) as! ItemTableViewCell

        cell.name.text = item.name
        cell.value.text = "\(item.value)"
 
        // set thumbnail image
        if let thumb = item.thumb {
            cell.itemImageView.image = UIImage(named: thumb)
        }
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            items.removeAtIndex(indexPath.row) // rm from data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        
        let b = items.removeAtIndex(fromIndexPath.row)
        items.insert(b, atIndex: toIndexPath.row)

    }
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "ShowItemSegue")
        {
            let detailViewController = segue.destinationViewController as! ItemDetailTableViewController
    
            let indexPath = tableView.indexPathForSelectedRow
            let row = indexPath!.row
            let item = items[row]
    
            detailViewController.item = item
            detailViewController.completionHandler = { item in
                //changing the actual model
                self.items[row] = item
            
                // update view
                self.tableView.reloadData()
            }
        }
        
        else if segue.identifier == "addItemSegue" {
            let navVC = segue.destinationViewController as! UINavigationController
            let detailViewController = navVC.topViewController as! ItemDetailTableViewController
            let item = Item(name: "New Name", itemID: 1, description: "New Description", image: nil, thumb: nil, value: 1)
            items.insert(item, atIndex: 0)
            
            // same as above, but row=0
            detailViewController.item = item
            detailViewController.completionHandler = { item in
                //changing the actual model.  we know row = 0
                self.items[0] = item
                
                // update view
                self.tableView.reloadData()
            }
            // add a done button
            detailViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: detailViewController, action: "done")

        }
    
    }
    
    @IBAction func addItem(sender: AnyObject) {
    }

}
