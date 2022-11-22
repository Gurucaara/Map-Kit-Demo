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
        let location = CLLocation(latitude: 43.0004457, longitude: -81.3296235)
        
        let region = MKCoordinateRegion(center: <#T##CLLocationCoordinate2D#>, latitudinalMeters: <#T##CLLocationDistance#>, longitudinalMeters: <#T##CLLocationDistance#>)
        
        mapView.setRegion(<#T##region: MKCoordinateRegion##MKCoordinateRegion#>, animated: true)
        
    }


}

