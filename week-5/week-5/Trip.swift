//
//  Trip.swift
//  TripAdvisor App
//
//  Created by Mohamed Abdelrazek on 16/4/18.
//  Copyright © 2018 Deakin. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class Trip : NSObject, MKAnnotation {
    
    var tripDate : String
    var tripDuration : Int
    var tripDestination: String
    var img : UIImage
    var title : String?
    var subTitle : String?
    var coordinate : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    init(_ date : String,_ duration : Int, _ destination : String,_ image : UIImage) {
        
        tripDate = date
        tripDuration = duration
        tripDestination = destination
        img = image
        
        title = tripDestination
        subTitle = tripDate.description
        
        super.init()
        getLocationFromDestination()
    }
    
    func getLocationFromDestination() {
        CLGeocoder().geocodeAddressString(tripDestination) {
            (placemarks, error) in
            let placemark = placemarks?.first
            self.coordinate = (placemark?.location?.coordinate)!
        }
    }
}

class Trips {
    static var trips = [Trip] ()
    
    static func getTrips() -> [Trip] {
        return trips
    }
    static func loadTrips() {
        
        trips = [
            Trip( "2017/10/04" , 10, "Melbourne" , UIImage(named: "melbourne")!),
            Trip( "2018/10/04" , 15, "Sydney"    , UIImage(named: "sydney")!),
            Trip( "2018/11/04" , 20, "Adelaide"  , UIImage(named: "adelaide")!)
        ]
        

    }
    static func getTrip(at : Int) -> Trip? {
        if trips.count < 1 { loadTrips() }
        
        if at >= 0 && at < trips.count {
            return trips[at]
        }
        return nil
    }
    
    
}
