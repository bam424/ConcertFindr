//
//  MapViewController.swift
//  ConcertFindr
//

//  Created by Patricia Au on 5/23/17.

import UIKit

import MapKit

class MapViewController: UIViewController {
    var annotations = [ConcertPin]() //Array of concert pin objects to populate map
   
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initial pointer - change this upon api call finished
        var initialLocation = CLLocation(latitude: 47.6062, longitude: -122.3321)
        
        if annotations.count > 0 {
            print(annotations[0].coordinate)
            let initLat = annotations[0].coordinate.latitude
            let initLong = annotations[0].coordinate.longitude
            initialLocation = CLLocation(latitude: initLat, longitude: initLong)
            mapView.addAnnotations(annotations)
            print("Added pin")
        } else {
            print("Did not add pins")
            print(annotations)
        }
        
        centerMapOnLocation(location: initialLocation)
    }

    //regionRadius: what the zoom level should be
    let regionRadius: CLLocationDistance = 1000
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        
        //After API call, add to map
        //Loop through all data points -> turn into ConcertPin object
        //mapView.addAnnotation(<#T##annotation: MKAnnotation##MKAnnotation#>)
//        mapView.addAnnotations([""])
    }
    
    //Get information - pass information to details page
    /*

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
