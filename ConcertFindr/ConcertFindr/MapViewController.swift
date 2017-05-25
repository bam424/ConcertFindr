//
//  MapViewController.swift
//  ConcertFindr
//
//  Created by Patricia Au on 5/23/17.
//  Copyright © 2017 Derek Han. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    //Make sure to redo this when pulling
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initial pointer - change this upon api call finished
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        centerMapOnLocation(location: initialLocation)
    }

    //regionRadius: what the zoom level should be
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        
        //After API call, add to map
        //Loop through all data points -> turn into ConcertPin object
        mapView.addAnnotation(<#T##annotation: MKAnnotation##MKAnnotation#>)
    }
    
    //Get information - pass information to details page
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
