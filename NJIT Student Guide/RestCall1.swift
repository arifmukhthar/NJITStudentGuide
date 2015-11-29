//
//  RestCall.swift
//  NJIT Student Guide
//
//  Created by Venkatesh Muthukrishnan on 10/24/15.
//  Copyright © 2015 Fantastic4. All rights reserved.
//

import Foundation
class RestCall1 {
    
    var userName = [String]()
    var bookDescription = [String]()
    var bookName = [String]()
    var userEmail = [String]()
    
    func getJSON(url: String) {
        let data = NSData(contentsOfURL: NSURL(string: url)!)
        do {
            
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray
            var i = 0
            for _ in jsonResult!
            {
                
                let data=jsonResult![i];
                
                self.userName.append(data["userName"] as! String)
                self.bookDescription.append(data["bookDescription"] as! String)
                self.bookName.append(data["bookName"] as! String)
                self.userEmail.append(data["userEmail"] as! String)
                i = i+1
                
            }
            print(jsonResult)
            
        } catch let error as NSError {
            print(error)
        }
    }
}