//
//  ViewController.swift
//  ShareLocation
//
//  Created by PrincePhoenix on 07.07.2021.
//

//import UIKit
//import MapKit
//import CoreLocation
//
//class LocationViewController: UIViewController {
//
//    // MARK: - properties
//    @IBOutlet var map: MKMapView!
//
//    @IBOutlet var locationLabel: UILabel!
//
//    @IBOutlet var blurContainer: UIVisualEffectView!
//    @IBOutlet var blurButtonContainer: UIVisualEffectView!
//
//    var pin = MKPointAnnotation()
//
//    let locationManager = CLLocationManager()
//
//    var lastLatitude: CLLocationDegrees?
//    var lastLongitude: CLLocationDegrees?
//    var lastCoordinate: CLLocationCoordinate2D? {
//        didSet {
//            lastLatitude = lastCoordinate?.latitude
//            lastLongitude = lastCoordinate?.longitude
//
//            pin.coordinate = lastCoordinate!
//            updateLabel()
////          locationLabel.text =
//
//        }
//    }
//
//
//
//    // MARK: - setup
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewDidLoad()
//        ///Setup blur containers
//        blurContainer.layer.cornerRadius = 25
//        blurContainer.layer.masksToBounds = true
//        blurButtonContainer.layer.cornerRadius = 25
//        blurButtonContainer.layer.masksToBounds = true
//
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//
//        map.addAnnotation(pin) //?
//    }
//
//    // MARK: - render location
//
//    func render() {
//        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//        let region = MKCoordinateRegion(center: lastCoordinate!, span: span)
//        map.setRegion(region, animated: true)
//    }
//
//    func updateLabel() {
//        let firstLine = "My location:\n"
//        let secondLine = String(format: "Latitude: %.2f\n", lastLatitude!)
//        let thirdLine = String(format: "Longtitude: %2.f", lastLongitude!)
//        let text = firstLine + secondLine + thirdLine
//        locationLabel.text = text
//    }
//
//    @IBAction func shareButtonTapped(_ sender: UIButton) {
//        locationManager.startUpdatingLocation()
//        locationManager.requestLocation()
//        guard lastCoordinate != nil else { return }
//        let text = locationLabel.text!
//        let vc = UIActivityViewController(activityItems: [text], applicationActivities: [])
//        vc.popoverPresentationController?.sourceView = blurButtonContainer
//        present(vc, animated: true)
//    }
//}
//
//// MARK: - Location Manager Delegate
//
//extension LocationViewController: CLLocationManagerDelegate {
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.last {
//            manager.stopUpdatingLocation()
//
//            lastCoordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
//                                                    longitude: location.coordinate.longitude)
//            render()
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print(error.localizedDescription.description)
//    }
//}

//
//import Foundation
//import CoreLocation
//
//class XLocation : NSObject , CLLocationManagerDelegate {
//
//    static var shared = XLocation()
//
//
//    var locationManager : CLLocationManager!
//
//    func getMyLocation() {
//
//        locationManager = CLLocationManager()
//         locationManager.requestWhenInUseAuthorization()
//
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyBest
//            locationManager.distanceFilter = kCLDistanceFilterNone
//            locationManager.startUpdatingLocation()
//        }
//    }
//
//    var longtude = Double()
//    var latitude = Double()
//
//    var gotLocation : (()->())?
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        self.longtude = locations[0].coordinate.longitude
//        self.latitude = locations[0].coordinate.latitude
//        gotLocation?()
//        locationManager.stopUpdatingLocation()
//
//    }
//
//    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
//        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
//            completion(placemarks?.first?.locality,
//                       placemarks?.first?.country,
//                       error)
//        }
//    }
//}
