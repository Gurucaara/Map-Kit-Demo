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
        let annotation = MyAnnotation(coordinate: location.coordinate, title: "My Title", subtitle: "My Subtitle Here", glyphText: "Puru" )
        // 11. Adding the map annotation
        mapView.addAnnotation(annotation)
    }
    
    //3. making up function for setup map
    private func setupMap() {
        //        19. Setting up the delegate for the map
        mapView.delegate = self
        
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
//18. calling extension for callout
extension ViewController: MKMapViewDelegate {
    // 19. calling map view delegate function
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "What is this ?"
        let view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        
        
        view.canShowCallout = true
        
        // 20. set the position of the callout
        view.calloutOffset = CGPoint(x: 0, y: 10)
        
        // 21. to add functionalities or button to the right side of the callout
        let button = UIButton(type: .detailDisclosure)
        view.rightCalloutAccessoryView = button
        
        // 22. add image to left side of the callout
        let image = UIImage(systemName: "graduationcap.circle.fill")
        view.leftCalloutAccessoryView = UIImageView(image: image)
        
        // 23. Change color of the pin/marker
        view.markerTintColor = UIColor.purple
        
        // 24. change the colour of the accessories
        view.tintColor = UIColor.systemMint
        
        // 25. what if you wanted to show gliph
        //        view.glyphText = annotation.glyphText
        // Performing optional binding with type casting
        if let myAnnotation = annotation as? MyAnnotation {
            view.glyphText = myAnnotation.glyphText
        }
        
        return view
    }
    
}


//13. MKAnnotation want us to start it from a class {need ns object}
class MyAnnotation : NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    //17. adding more Strings
    var title: String?
    var subtitle: String?
    var glyphText: String?
    
    // 14. giving it an initiallizer
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, glyphText: String? = nil ){
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.glyphText = glyphText
        //will set colours here too
        
        // set super after initiallising
        super.init()
    }
    
}

