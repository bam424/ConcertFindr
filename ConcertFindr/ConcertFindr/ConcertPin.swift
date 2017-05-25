//
//  ConcertPin.swift
//  ConcertFindr
//
//  Created by Patricia Au on 5/23/17.
//  Copyright © 2017 Derek Han. All rights reserved.
//

import Foundation
import MapKit

class ConcertPin: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    //let image: UIImage
    let artist: String
    let startTime: NSDate
    let ageRestriction: String
    let venueName: String
    let listenURL: String
    let ticketsURL: String
    
    //Turn image into UIImage within init
    //Turn lat and long into CLLocation
    init(artist: String, startTime: NSDate, ageRestriction: String, venueName: String, listenURL: String, ticketsURL: String, coordinate: CLLocationCoordinate2D) {
        
        //self.image = image
        self.artist = artist
        self.startTime = startTime
        self.ageRestriction = ageRestriction
        self.venueName = venueName
        self.listenURL = listenURL
        self.ticketsURL = ticketsURL
        self.coordinate = coordinate
        
        //This is necessary if latitude and longitude are passed in
        //coordinate = CLLocationCoordinate2D(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
    }
}
