//
//  BroadcastInfoViewController.swift
//  NJIT Student Guide
//
//  Created by Ishani Chatterjee on 11/27/15.
//  Copyright © 2015 Fantastic4. All rights reserved.
//

import UIKit
import EventKit

class BroadcastInfoViewController: UIViewController {
    var id = String()
    var tit = String()
    var msg = String()
    var dt = String()
    var tim = String()
    var from = String()
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var msglbl: UILabel!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var timelbl: UILabel!
    @IBOutlet weak var fromlbl: UILabel!
    override func viewDidLoad() {
        print("id is \(id)")
        getJSON("https://web.njit.edu/~rb454/broadcastpost.php")
        print(NSDate())
        super.viewDidLoad()
    }
    
    func getJSON(url: String){
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        
        let parameter = "data=\(id)"
        
        request.HTTPBody = parameter.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {data,response,error -> Void in
        print("data is \(data)")
            do
            {
                var i = 0
            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray
                print(json)
                for _ in json!{
                    let dd = json![i]
                    self.tit = (dd["Title"] as? String)!
                    self.msg = (dd["Message"] as? String)!
                    self.dt = (dd["EventDate"] as? String)!
                    self.tim = (dd["EventTime"] as? String)!
                    self.from = (dd["FromMsg"] as? String)!
                    i++
                }
                dispatch_async(dispatch_get_main_queue(), {
                   self.titlelbl.text = self.tit
                    self.msglbl.text = self.msg
                    self.datelbl.text = self.dt
                    self.timelbl.text = self.tim
                    self.fromlbl.text = self.from
                });
                print(json)
            }catch _ as NSError{
                
            }
            
        })
        
        task.resume()
    }
    @IBAction func addEventToCalendar(sender: AnyObject) {
        
        let eventStore = EKEventStore()
        
        let datetime = "\(dt) \(tim)"
        print(datetime)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let date = dateFormatter.dateFromString(datetime)
        print(date)
        let startDate = date
        let endDate = startDate!.dateByAddingTimeInterval(3600)
        
        if (EKEventStore.authorizationStatusForEntityType(.Event) != EKAuthorizationStatus.Authorized){
            eventStore.requestAccessToEntityType(.Event, completion: {
                granted,error in
                self.createEvent(eventStore, title: self.tit, startDate: startDate!, endDate: endDate)
                
            })
        }else{
            createEvent(eventStore, title: self.tit, startDate: startDate!, endDate: endDate)
        }
  
        
        let mailAlert = UIAlertView(title: "Successfully Added to calendar", message: "\(tit) is successfully added to your calendar", delegate: self, cancelButtonTitle: "Done")
        mailAlert.show()
        
    }
    
    func createEvent(eventStore: EKEventStore,title: String,startDate: NSDate,endDate: NSDate){
        
        let event = EKEvent(eventStore: eventStore)
        
        event.title = title
        event.startDate = startDate
        event.endDate = endDate
        event.calendar = eventStore.defaultCalendarForNewEvents
        do{
            try eventStore.saveEvent(event, span: .ThisEvent)
            
        }catch{
            print("Could not add event to calendar")
        }
        
    }
}
