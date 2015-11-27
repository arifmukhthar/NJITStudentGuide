//
//  GetPredictions.swift
//  NJIT Student Guide
//
//  Created by Ishani Chatterjee on 11/26/15.
//  Copyright © 2015 Fantastic4. All rights reserved.
//:

import Foundation

class GetPredictions {
    static var myDict : [String:String] = [:]
    static func getPred(route: String){
        print("get Predictions function called for route: \(route)")
        let url = "http://runextbus.herokuapp.com/route/\(route)"
        let data = NSData(contentsOfURL: NSURL(string: url)!)
        do{
            let JSONresult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray
            print("!My JSON Result\(JSONresult)")
            for items in JSONresult!{
                var min : String = ""
                
                
                if let p = items["predictions"]!![0] as? NSDictionary{
                    
                    if items["predictions"]!!.count > 1{
                        let p2 = items["predictions"]!![1] as? NSDictionary
                        min = " , " + (p2!["minutes"] as? String)!
                    }
                    
                    min = (p["minutes"] as? String)! + min
                    
                    myDict[(items["title"] as? String)!] = min + " min"
                    
                    
                }else
                {
                    myDict[(items["title"] as? String)!] = "No Predictions"
                }
                
            }
            print(myDict)
            
        }catch let error as NSError{
            print(error)
        }
    }
    
   
}
