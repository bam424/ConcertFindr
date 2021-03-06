//
//  ConcertPin.swift
//  ConcertFindr
//
//  Created by iGuest on 5/25/17.

import Foundation
import MapKit

class ConcertPin: NSObject {
    let coordinate: CLLocationCoordinate2D
    //let image: UIImage
//    let title: String?
//    let subtitle: String?
    let artist: [String]
    let artistID: String
    let startTime: String
    let eventDate: String
    let ageRestriction: String
    let venueName: String
    let listenURL: String
    let ticketsURL: String
    
    //Turn image into UIImage within init
    //Turn lat and long into CLLocation
    init(artist: [String], artistID: String, startTime: String, eventDate: String, ageRestriction: String, venueName: String, listenURL: String, ticketsURL: String, latitude: Double, longitude: Double) {
        
        //self.image = image
        self.artist = artist
        self.artistID = artistID
        self.startTime = startTime
        self.eventDate = eventDate
        self.ageRestriction = ageRestriction
        self.venueName = venueName
        self.listenURL = listenURL
        self.ticketsURL = ticketsURL
        
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
//        self.title = "\(artist.joined(separator: ", ")) @ \(venueName)"
//        self.subtitle = "Age restriction: \(ageRestriction)"
    }
}
