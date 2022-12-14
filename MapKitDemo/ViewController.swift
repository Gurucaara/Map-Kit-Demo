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
        addLondonAnnotation(location: getDelhiLocation())
    }
    
    // 16. Declaring the CLLocation in new function
    private func getFanshaweLocation()-> CLLocation {
        return CLLocation(latitude: 43.0130, longitude: -81.1994 )
    }
    private func getDelhiLocation() -> CLLocation {
        return CLLocation(latitude: 43.0307, longitude: -81.1494)
    }
    // 10. Creating a new function for adding the annotation
    private func addAnnotation (location: CLLocation) {
        //12. making annotation for mapView.addAnnotation
        //whereas MKAnnotation is not a class or a function it's an protocol
        let annotation = MyAnnotation(coordinate: location.coordinate, title: "My Title", subtitle: "My Subtitle Here", glyphText: "Puru" , markerTintColour: UIColor.systemBlue)
        // 11. Adding the map annotation
        mapView.addAnnotation(annotation)
    }
    private func addLondonAnnotation (location: CLLocation) {
        let annotation2 = MyAnnotation(coordinate: location.coordinate, title: "London Airport", subtitle: "Airport", glyphText: "Mumma", markerTintColour: UIColor.systemPink)
        mapView.addAnnotation(annotation2)
        
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
        let radiusInMeter : CLLocationDistance = 10000
        
        let region = MKCoordinateRegion(center: location.coordinate,
                                        latitudinalMeters: radiusInMeter,
                                        longitudinalMeters: radiusInMeter)
        
        //7. Setting up the reigon
        mapView.setRegion(region, animated: true)
        
//        //8. Setting camera boundary
        let cameraBoundary = MKMapView.CameraBoundary(coordinateRegion: region)
        mapView.setCameraBoundary(cameraBoundary, animated: true)
//
//        //9. setting up control zooming
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 100000)
        mapView.setCameraZoomRange(zoomRange, animated: true)
        
    }
    
    
}
//18. calling extension for callout
extension ViewController: MKMapViewDelegate {
    // 19. calling map view delegate function
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "myIdentifier"
        // 25. changing the view
        var view : MKMarkerAnnotationView
        // 24. identifier adapting the deque
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        {
            // get updated annotation
            dequeuedView.annotation = annotation
            
            // use resuable view
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            
            view.canShowCallout = true
            
            // 20. set the position of the callout
            view.calloutOffset = CGPoint(x: 0, y: 10)
            
            // 21. to add functionalities or button to the right side of the callout
            let button = UIButton(type: .detailDisclosure)
            //27. calling it with a tag
            button.tag = 100
            view.rightCalloutAccessoryView = button
            
            // 22. add image to left side of the callout
            let image = UIImage(systemName: "graduationcap.circle.fill")
            view.leftCalloutAccessoryView = UIImageView(image: image)
            
            // 23. Change color of the pin/marker
            if let myMarkerAnnotation = annotation as? MyAnnotation{
                view.markerTintColor = myMarkerAnnotation.markerTintColor
            }
    //        view.markerTintColor = UIColor.purple
            
            // 24. change the colour of the accessories
            view.tintColor = UIColor.systemMint
            
            // 25. what if you wanted to show gliph
            //        view.glyphText = annotation.glyphText
            // Performing optional binding with type casting
            if let myAnnotation = annotation as? MyAnnotation {
                view.glyphText = myAnnotation.glyphText
            }
            
            
        }
       
        return view
    }
    //26. can checkout some function and here we will have accessory controlled out
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print ("Button clicked \(control.tag)")
            // using a guard statement with optional binding
        guard let coordinates = view.annotation?.coordinate else {
            return
        }
         
        let launchOptions = [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking
        ]
        // 27. click on the button and get you the direction to how to get there
        // use the apple map item
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinates))
        mapItem.openInMaps(launchOptions: launchOptions)
    }
}


//13. MKAnnotation want us to start it from a class {need ns object}
class MyAnnotation : NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    //17. adding more Strings
    var title: String?
    var subtitle: String?
    var glyphText: String?
    var markerTintColor : UIColor?
    
    // 14. giving it an initiallizer
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, glyphText: String? = nil, markerTintColour: UIColor? = UIColor.systemOrange){
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.glyphText = glyphText
        self.markerTintColor = markerTintColour
        
        //will set colours here too
        
        // set super after initiallising
        super.init()
    }
    
}

