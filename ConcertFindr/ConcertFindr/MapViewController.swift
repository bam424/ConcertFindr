//
//  MapViewController.swift
//  ConcertFindr
//

//  Created by Patricia Au on 5/23/17.

import UIKit

import MapKit

class ConcertAnnotation : MKPointAnnotation {
    var concert : ConcertPin?
}

class MapViewController: UIViewController {
    var annotations = [ConcertPin]() //Array of concert pin objects to populate map
    var selectedAnnotation: ConcertAnnotation!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        //Initial pointer - change this upon api call finished
        var initialLocation = CLLocation(latitude: 47.6062, longitude: -122.3321)
        
        if annotations.count > 0 {
            let initLat = annotations[0].coordinate.latitude
            let initLong = annotations[0].coordinate.longitude
            initialLocation = CLLocation(latitude: initLat, longitude: initLong)
            for annotation in annotations {
                let newAnnotation: ConcertAnnotation = ConcertAnnotation()
                newAnnotation.title = "\(annotation.artist.joined(separator: ", ")) @ \(annotation.venueName)"
                newAnnotation.subtitle = "Age restriction: \(annotation.ageRestriction)"
                newAnnotation.coordinate = annotation.coordinate
                newAnnotation.concert = annotation
                mapView.addAnnotation(newAnnotation)
            }
        } else {
            let alert = UIAlertController(title: "No Concert Data", message: "Could not find concerts with your search.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        centerMapOnLocation(location: initialLocation)
    }
    
    

    let regionRadius: CLLocationDistance = 4500
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
