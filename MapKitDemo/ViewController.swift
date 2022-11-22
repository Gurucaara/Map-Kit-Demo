//
//  ViewController.swift
//  MapKitDemo
//
//  Created by Puru Rana on 2022-11-22.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupMap()
    }
    
    private func setupMap() {
        //43.0004457, -81.3296235
        let location = CLLocation(latitude: 43.0130, longitude: -81.1994 )
        
        //where we are currently and you want to see beyond that point
        let radiusInMeter : CLLocationDistance = 1000
        
        let region = MKCoordinateRegion(center: location.coordinate,
                                        latitudinalMeters: radiusInMeter,
                                        longitudinalMeters: radiusInMeter)
        
        mapView.setRegion(region, animated: true)
        
        //Camera boundary
        let cameraBoundary = MKMapView.CameraBoundary(coordinateRegion: region)
        mapView.setCameraBoundary(cameraBoundary, animated: true)
        
        //control zooming
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 100000)
        mapView.setCameraZoomRange(zoomRange, animated: true)
        
    }
    
    
}

