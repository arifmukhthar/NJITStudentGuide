//
//  ShuttleMapViewController.swift
//  NJIT Student Guide
//
//  Created by Mac on 11/4/15.
//  Copyright © 2015 Fantastic4. All rights reserved.
//40.743193, -74.178550

import UIKit
import MapKit

class ShuttleMapViewController: UIViewController {

    @IBOutlet weak var myMap: MKMapView!
    
    
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var date = NSMutableString()
        
    override func viewDidLoad() {
        let initialLocation = CLLocation(latitude: 40.743193, longitude: -74.178550)
        centerMapOnLocation(initialLocation)
        super.viewDidLoad()
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        myMap.setRegion(coordinateRegion, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
