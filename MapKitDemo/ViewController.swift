//
//  ViewController.swift
//  MapKitDemo
//
//  Created by Puru Rana on 2022-11-22.
//

import UIKit
//2. importing map kit
import MapKit

class ViewController: UIViewController {
    // 1. Taking outlet of map from main screen
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 4. calling setupmap function
        setupMap()
        
        // 15. Now calling the addAnnotation
        addAnnotation(location: getFanshaweLocation())
    }
    
    // 16. Declaring the CLLocation in new function
    private func getFanshaweLocation()-> CLLocation {
        return CLLocation(latitude: 43.0130, longitude: -81.1994 )
    }
    
    // 10. Creating a new function for adding the annotation
    private func addAnnotation (location: CLLocation) {
        //12. making annotation for mapView.addAnnotation
        //whereas MKAnnotation is not a class or a function it's an protocol
        let annotation = MyAnnotation(coordinate: location.coordinate)
        // 11. Adding the map annotation
        mapView.addAnnotation(annotation)
    }
    
    //3. making up function for setup map
    private func setupMap() {
        //5. our college coordinate
        //43.0004457, -81.3296235
//        let location = CLLocation(latitude: 43.0130, longitude: -81.1994 )
        let location = getFanshaweLocation()
        
        //6.where we are currently and you want to see beyond that point
        let radiusInMeter : CLLocationDistance = 1000
        
        let region = MKCoordinateRegion(center: location.coordinate,
                                        latitudinalMeters: radiusInMeter,
                                        longitudinalMeters: radiusInMeter)
        
        //7. Setting up the reigon
        mapView.setRegion(region, animated: true)
        
        //8. Setting camera boundary
        let cameraBoundary = MKMapView.CameraBoundary(coordinateRegion: region)
        mapView.setCameraBoundary(cameraBoundary, animated: true)
        
        //9. setting up control zooming
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 100000)
        mapView.setCameraZoomRange(zoomRange, animated: true)
        
    }
    
    
}
//13. MKAnnotation want us to start it from a class {need ns object}
class MyAnnotation : NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    
    // 14. giving it an initiallizer
    init(coordinate: CLLocationCoordinate2D){
        self.coordinate = coordinate
        
        // set super after initiallising
        super.init()
    }
    
}

