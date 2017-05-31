//
//  ConcertPin.swift
//  ConcertFindr
//
//  Created by iGuest on 5/25/17.

import Foundation
import MapKit

class ConcertPin: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    //let image: UIImage
    let artist: [String]
    let artistID: String
    let startTime: String
    let ageRestriction: String
    let venueName: String
    let listenURL: String
    let ticketsURL: String
    
    //Turn image into UIImage within init
    //Turn lat and long into CLLocation
    init(artist: [String], artistID: String, startTime: String, ageRestriction: String, venueName: String, listenURL: String, ticketsURL: String, latitude: Double, longitude: Double) {
        
        //self.image = image
        self.artist = artist
        self.artistID = artistID
        self.startTime = startTime
        self.ageRestriction = ageRestriction
        self.venueName = venueName
        self.listenURL = listenURL
        self.ticketsURL = ticketsURL
        
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

        
        //This is necessary if latitude and longitude are passed in
        //coordinate = CLLocationCoordinate2D(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
    }
}
