//
//  RestaurantDetailMapCell.swift
//  FoodPin
//
//  Created by 山本響 on 2021/08/01.
//

import UIKit
import MapKit

class RestaurantDetailMapCell: UITableViewCell {
    
    @IBOutlet var mapView: MKMapView! {
        didSet {
            mapView.layer.cornerRadius = 20
            mapView.clipsToBounds = true
        }
    }
    
    func configure(location: String) {
        // Get location
        let geoCoder = CLGeocoder()
        
        print(location)
        geoCoder.geocodeAddressString(location) { placeMarks, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let placemarks = placeMarks {
                // Get the first placemark
                let placemark = placemarks[0]
                
                // Add annotation
                let annotaion = MKPointAnnotation()
                
                if let location = placemark.location {
                    // Display the annotation
                    annotaion.coordinate = location.coordinate
                    self.mapView.addAnnotation(annotaion)
                    
                    // Set the zoom level
                    let region = MKCoordinateRegion(center: annotaion.coordinate, latitudinalMeters: 250, longitudinalMeters: 250)
                    self.mapView.setRegion(region, animated: false)
                }
            }
        }
    }

}
