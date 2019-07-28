//
//  MapViewController.swift
//  MapKit_Test2
//
//  Created by Дмитрий Ага on 7/27/19.
//  Copyright © 2019 Дмитрий Ага. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var closeBtn: UIButton!
    var place: Place?

    override func viewDidLoad() {
        super.viewDidLoad()
        closeBtn.layer.cornerRadius = 4
  
        if let selectPlace = place {
            let regionRadius: CLLocationDistance = 1000.0
            let coordinateRegion = MKCoordinateRegion(center: selectPlace.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            mapView.setRegion(coordinateRegion, animated: true)
            mapView.addAnnotation(selectPlace)
        }
    }

    @IBAction func closeBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func changeMapType(_ sender: UISegmentedControl) {

        if sender.selectedSegmentIndex == 0 {
            mapView.mapType = .standard
        } else {
            mapView.mapType = .satellite
        }
        
    }
    
}

extension MapViewController: MKMapViewDelegate {
    func mapViewWillStartLoadingMap(_ mapView: MKMapView) {
        print("localiz")
    }
}
