//
//  BroadcastViewController.swift
//  NJIT Student Guide
//
//  Created by Ishani Chatterjee on 11/27/15.
//  Copyright © 2015 Fantastic4. All rights reserved.
//

import UIKit

class BroadcastViewController: UITableViewController {

  
    var dateInfo = [String]()
    var titleInfo = [String]()
    var id = [String]()
    var idNA = String()
    override func viewDidLoad() {
        getJSON("https://web.njit.edu/~rb454/broadcast.php")
        idNA = "asdf"
    
        let postBtn : UIBarButtonItem = UIBarButtonItem(title: "Broadcast", style: UIBarButtonItemStyle.Plain, target: self, action: "postItemToBroadcast:")
        self.navigationItem.rightBarButtonItem = postBtn
        super.viewDidLoad()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateInfo.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BroadcastCell", forIndexPath: indexPath) as! BroadcastCell
        cell.dateLabel?.text = dateInfo[indexPath.row]
        cell.titleLabel?.text = titleInfo[indexPath.row]
        return cell
    }
    
    func getJSON(url: String){
        let data = NSData(contentsOfURL: NSURL(string: url)!)
        do{
            var i = 0
        let myJSON = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray
            for _ in myJSON!{
                let item = myJSON![i]
                dateInfo.append(item["EventDate"] as! String)
                titleInfo.append(item["Title"] as! String)
                id.append(item["id"] as! String)
                i++
            }
            print("\(dateInfo)  \(titleInfo)")
        }catch _ as NSError{
            
        }
        print(data)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!
        let destVC = segue.destinationViewController as! BroadcastInfoViewController
        
        destVC.id = id[indexPath.row]
        
    }
    func postItemToBroadcast(sender: UIBarButtonItem){
        UIApplication.sharedApplication().openURL(NSURL(string: "http://eventpost-cidcir9ze8.elasticbeanstalk.com")!)
        print("posting broadcast")
    }
}
