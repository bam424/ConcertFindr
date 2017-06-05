//
//  VCMapView.swift
//  ConcertFindr
//
//  Created by Patricia Au on 5/30/17.
//  Copyright © 2017 Derek Han. All rights reserved.
//

import Foundation
import MapKit

var selectedAnnotation: ConcertAnnotation!

extension MapViewController: MKMapViewDelegate {
    
    private func mapView(_ mapView: MKMapView, viewFor annotation: ConcertAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? ConcertAnnotation {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKPinAnnotationView { // 2
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                // 3
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.isEnabled = true
//                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
            return view
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            selectedAnnotation = view.annotation as! ConcertAnnotation
            performSegue(withIdentifier: "MapToDetails", sender: view)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MapToDetails" {
            let detailsPage = segue.destination as! ConcertDetailsViewController
            detailsPage.concertTitle = selectedAnnotation.title
            detailsPage.ageRestriction = selectedAnnotation.concert?.ageRestriction
            detailsPage.startTime = selectedAnnotation.concert?.startTime
            detailsPage.eventDate = selectedAnnotation.concert?.eventDate
            detailsPage.ticketURL = selectedAnnotation.concert?.ticketsURL
        }
    }
}
