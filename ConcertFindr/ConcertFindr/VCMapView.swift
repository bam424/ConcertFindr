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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? ConcertAnnotation {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation as MKAnnotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation as MKAnnotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.isEnabled = true
            }
            let infoButton = UIButton(type: .detailDisclosure)
            view.rightCalloutAccessoryView = infoButton
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
            let concertDetails = selectedAnnotation.concert
            detailsPage.concertTitle = concertDetails?.artist.joined(separator: ", ")
            detailsPage.ageRestriction = concertDetails?.ageRestriction
            detailsPage.venue = concertDetails?.venueName
            detailsPage.startTime = concertDetails?.startTime
            detailsPage.eventDate = concertDetails?.eventDate
            detailsPage.ticketURL = concertDetails?.ticketsURL
            detailsPage.artistID = concertDetails?.artistID
        }
    }
}
