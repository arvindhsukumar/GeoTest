//
//  ViewController.swift
//  GeoTest
//
//  Created by arvindh on 17/03/19.
//  Copyright © 2019 arvindh. All rights reserved.
//

import UIKit
import CoreLocation
import Contacts

class ViewController: UIViewController {
  @IBOutlet weak var label: UILabel!
  var locationManager: CLLocationManager!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    locationManager = CLLocationManager()
    locationManager.requestAlwaysAuthorization()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
  }

  func getLocation() {
    
  }
}

extension ViewController: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    locationManager.startUpdatingLocation()
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else {
      return
    }
    
    let geoCoder = CLGeocoder()
    geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
      guard let placemark = placemarks?.last else {
        return
      }
      
      let name = "Placemark Name:    \(placemark.name ?? "Unknown")"
      let country = "Country:    \(placemark.country ?? "Unknown")"
      let countryCode = "Country Code:    \(placemark.isoCountryCode ?? "Unknown")"
      let locality = "Locality:    \(placemark.locality ?? "Unknown")"
      let subLocality = "Sub Locality:    \(placemark.subLocality ?? "Unknown")"
      let subThoroughFare = "Sub Thoroughfare:    \(placemark.subThoroughfare ?? "Unknown")"
      let thoroughFare = "Thoroughfare:    \(placemark.thoroughfare ?? "Unknown")"
      let administrativeArea = "Administrative Area:    \(placemark.administrativeArea ?? "Unknown")"
      let subAdministrativeArea = "Sub-Administrative Area:    \(placemark.subAdministrativeArea ?? "Unknown")"
      let postalCode = "PostalCode:    \(placemark.postalCode ?? "Unknown")"
      
      self.label.text = [
        name,
        subThoroughFare,
        thoroughFare,
        subLocality,
        locality,
        postalCode,
        subAdministrativeArea,
        administrativeArea,
        country,
        countryCode
      ].joined(separator: ", \n")
    }    
  }
}
