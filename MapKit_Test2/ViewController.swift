//
//  ViewController.swift
//  MapKit_Test2
//
//  Created by Дмитрий Ага on 7/27/19.
//  Copyright © 2019 Дмитрий Ага. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var pikerView: UIPickerView!
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var discLable: UILabel!
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
    var places: [Place] = []
    var selectedPlace: Place? = nil
    
    let images = [UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3")]

    
    
//    let images = [UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3"), UIImage(named: "4"), UIImage(named: "5"), UIImage(named: "6"), UIImage(named: "7"), UIImage(named: "8"), UIImage(named: "9"), UIImage(named: "10"), UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3"), UIImage(named: "4"), UIImage(named: "5"), UIImage(named: "6"), UIImage(named: "7"), UIImage(named: "8"), UIImage(named: "9"), UIImage(named: "10"), UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3"), UIImage(named: "4"), UIImage(named: "5"), UIImage(named: "6"), UIImage(named: "7"), UIImage(named: "8"), UIImage(named: "9"), UIImage(named: "10"), UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3"), UIImage(named: "4"), UIImage(named: "5"), UIImage(named: "6"), UIImage(named: "7"), UIImage(named: "8"), UIImage(named: "9"), UIImage(named: "10"), UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3"), UIImage(named: "4"), UIImage(named: "5"), UIImage(named: "6"), UIImage(named: "7"), UIImage(named: "8"), UIImage(named: "9"), UIImage(named: "10"), UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3"), UIImage(named: "4"), UIImage(named: "5"), UIImage(named: "6"), UIImage(named: "7"), UIImage(named: "8"), UIImage(named: "9"), UIImage(named: "10"), UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3"), UIImage(named: "4"), UIImage(named: "5"), UIImage(named: "6"), UIImage(named: "7"), UIImage(named: "8"), UIImage(named: "9"), UIImage(named: "10"), UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3"), UIImage(named: "4"), UIImage(named: "5"), UIImage(named: "6"), UIImage(named: "7"), UIImage(named: "8"), UIImage(named: "9"), UIImage(named: "10"), UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3"), UIImage(named: "4"), UIImage(named: "5"), UIImage(named: "6"), UIImage(named: "7"), UIImage(named: "8"), UIImage(named: "9"), UIImage(named: "10"), UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3"), UIImage(named: "4"), UIImage(named: "5"), UIImage(named: "6"), UIImage(named: "7"), UIImage(named: "8"), UIImage(named: "9"), UIImage(named: "10")]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let rotationAngle: CGFloat = -90 * (.pi/180)
        let y = pikerView.frame.origin.y
        pikerView.transform = CGAffineTransform(rotationAngle: rotationAngle)
        pikerView.frame = CGRect(x: -100, y: y, width: view.frame.width + 200, height: 50)
        myImageView.image = images[0]
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
        selectedPlace = places.first
   
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapSegue" {

            guard let mapController = segue.destination as? MapViewController,
                let selectedPlace = selectedPlace else { return }
            mapController.place = selectedPlace
        }
    }

    //MARK - Actions
    @IBAction func pushBtnWasPresset(_ sender: Any) {
        
        let position = Int(arc4random_uniform(3))
        
        pikerView.selectRow(position, inComponent: 0, animated: true)
        let actualRow = pikerView.selectedRow(inComponent: 0)
        print("Вы выбрали элемент \(actualRow)")
        
        let places = Place.getPlaces()
        
        let selectPlace = places[actualRow]
        titleLable.text = selectPlace.title
        discLable.text = selectPlace.subtitle
        let selectImage = UIImage(named: selectPlace.image!)
        myImageView.image = selectImage
        selectedPlace = selectPlace
    }
    
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    //MARK: - UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return images.count
    }
    
    //MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let vieww = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        let myImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        myImage.image = images[row]
        vieww.addSubview(myImage)
        vieww.transform = CGAffineTransform(rotationAngle: (90 * (.pi/180)))
        return vieww
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        myImageView.image = images[row]
        let actualRow = pikerView.selectedRow(inComponent: 0)
        print("Вы выбрали элемент \(actualRow)")
    }
    
}
extension ViewController: CLLocationManagerDelegate { }

