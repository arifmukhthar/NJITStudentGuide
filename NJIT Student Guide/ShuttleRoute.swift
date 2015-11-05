//
//  ShuttleRoute.swift
//  NJIT Student Guide
//
//  Created by Mac on 11/5/15.
//  Copyright © 2015 Fantastic4. All rights reserved.
//

import UIKit
class ShuttleRoute: NSObject,NSXMLParserDelegate{
    var parser:NSXMLParser = NSXMLParser()
    var ename : String = String()
    var routeTitle = String()
    var stopTag = String()
    var pointLat = String()
    var pointLon = String()
    var dirBool = false
    var retString = [String]()
    
    var map = String()
    func getLatLon(map: String)->[String] {
        self.map = map
        let url:NSURL = NSURL(string: "http://webservices.nextbus.com/service/publicXMLFeed?a=rutgers&command=routeConfig")!
        
        parser = NSXMLParser(contentsOfURL: url)!
        parser.delegate = self
        
        parser.parse()
        
        return retString
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        ename = elementName
        if elementName == "route"
        {
            routeTitle = attributeDict["title"]! as String
        }
        if elementName == "stop"
        {
            stopTag = attributeDict["tag"]! as String
        }
        if elementName == "direction"
        {
            dirBool = true
        }
        if elementName == "path"
        {
            dirBool = false
        }
        if elementName == "point"
        {
            pointLat = attributeDict["lat"]! as String
            pointLon = attributeDict["lon"]! as String
        }
    }
    func parser(parser: NSXMLParser, foundCharacters string: String) {
    
     }
    
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName == "stop" && !dirBool)
        {
           // print(routeTitle+" "+stopTag)
           // retString.append(routeTitle+" "+stopTag)
        }
        if elementName == "point" && routeTitle == map
        {
         //   print(routeTitle+" "+pointLat+" "+pointLon)
            retString.append(pointLat+" "+pointLon)
        }
    }
    

}
