//
//  MapViewController.swift
//  FoodPin
//
//  Created by 山本響 on 2021/08/01.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    var locationManager:CLLocationManager = CLLocationManager()
    
    var restaurant = Restaurant()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = false
        mapView.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsTraffic = true
        

        // Convert address to coordinate and annotate it on map
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location) { placemarks, error in
            if let error = error {
                print(error)
                return
            }
            
            if let placemarks = placemarks {
                // Get the first placemark
                let placemark = placemarks[0]
                
                if let location = placemark.location {
                    // Do any additional setup after loading the view, typically from a nib.
                    
                    let sourceLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude - 0.005, longitude: location.coordinate.longitude - 0.005)
                    let destinationLocation = location.coordinate
                    
                    // 3.
                    let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
                    let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
                    
                    // 4.
                    let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
                    let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
                    
                    // 5.
                    let sourceAnnotation = MKPointAnnotation()
                    sourceAnnotation.title = "YOU"

                    
                    if let location = sourcePlacemark.location {
                        sourceAnnotation.coordinate = location.coordinate
                    }
                    
                    
                    let destinationAnnotation = MKPointAnnotation()
                    destinationAnnotation.title = self.restaurant.name
                    destinationAnnotation.subtitle = self.restaurant.type
                    
                    if let location = destinationPlacemark.location {
                        destinationAnnotation.coordinate = location.coordinate
                    }
                    
                    // 6.
                    self.mapView.showAnnotations([sourceAnnotation, destinationAnnotation], animated: true )
                    
                    // 7.
                    let directionRequest = MKDirections.Request()
                    directionRequest.source = sourceMapItem
                    directionRequest.destination = destinationMapItem
                    directionRequest.transportType = .walking
                    
                    // Calculate the direction
                    let directions = MKDirections(request: directionRequest)
                    
                    // 8.
                    directions.calculate {
                        (response, error) -> Void in
                        
                        guard let response = response else {
                            if let error = error {
                                print("Error: \(error)")
                            }
                            return
                        }
                        
                        let route = response.routes[0]
                        self.mapView.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)
                    }
                }
            }
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    
    //this delegate function is for displaying the route overlay and styling it
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
         let renderer = MKPolylineRenderer(overlay: overlay)
         renderer.strokeColor = UIColor.red
         renderer.lineWidth = 5.0
         return renderer
    }
}
