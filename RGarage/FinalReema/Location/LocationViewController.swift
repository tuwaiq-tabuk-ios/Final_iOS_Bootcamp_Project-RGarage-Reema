//////
//////  LocationViewController.swift
//////  FinalReema
//////
//////  Created by Reema Mousa on 06/06/1443 AH.
//////
//
import UIKit
import MapKit
import CoreLocation

class LocationViewController: UIViewController {

 
  @IBOutlet weak var mapView: MKMapView!
 
  
  override func viewDidLoad() {
      super.viewDidLoad()
      mapView.delegate = self
      let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap))
      mapView.addGestureRecognizer(longTapGesture)
    
    
//      var geocoder = CLGeocoder()
//      geocoder.geocodeAddressString("47713 TABUK") {
//          placemarks, error in
//          let placemark = placemarks?.first
//          let lat = placemark?.location?.coordinate.latitude
//          let lon = placemark?.location?.coordinate.longitude
//          print("Lat: \(lat), Lon: \(lon)")
//      }
   
  }

  @objc func longTap(sender: UIGestureRecognizer){
      print("long tap")
      if sender.state == .began {
          let locationInView = sender.location(in: mapView)
          let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
          print("\n**Location on map: \(locationOnMap)")
      
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationOnMap
        
      
        //annotation.subtitle = "Some Subtitle"
        self.mapView.addAnnotation(annotation)
         
            var center : CLLocationCoordinate2D = CLLocationCoordinate2D()


            let ceo: CLGeocoder = CLGeocoder()
        center.latitude = locationOnMap.latitude
        center.longitude = locationOnMap.longitude

            let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)


            ceo.reverseGeocodeLocation(loc, completionHandler:
                {(placemarks, error) in
                    if (error != nil)
                    {
                        print("reverse geodcode fail: \(error!.localizedDescription)")
                    }
                    let pm = placemarks! as [CLPlacemark]

                    if pm.count > 0 {
                        let pm = placemarks![0]
                        print(pm.country)
                        print(pm.locality)
                        print(pm.subLocality)
                        print(pm.thoroughfare)
                        print(pm.postalCode)
                        print(pm.subThoroughfare)
                        var addressString : String = ""
                        if pm.subLocality != nil {
                            addressString = addressString + pm.subLocality! + ", "
                        }
                        if pm.thoroughfare != nil {
                            addressString = addressString + pm.thoroughfare! + ", "
                        }
                        if pm.locality != nil {
                            addressString = addressString + pm.locality! + ", "
                        }
                        if pm.country != nil {
                            addressString = addressString + pm.country! + ", "
                        }
                        if pm.postalCode != nil {
                            addressString = addressString + pm.postalCode! + " "
                        }

                      annotation.title =    addressString

                        print(addressString)
                  }
            })

        }

        
      
    
   
    
    
  }//long tap function end
    
    
  }




extension LocationViewController: MKMapViewDelegate{
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
      guard annotation is MKPointAnnotation else { print("no mkpointannotaions"); return nil }
      
      let reuseId = "pin"
      var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
      
      if pinView == nil {
          pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
          pinView!.canShowCallout = true
          pinView!.rightCalloutAccessoryView = UIButton(type: .infoDark)
          pinView!.pinTintColor = UIColor.black
      }
      else {
          pinView!.annotation = annotation
      }
      return pinView
  }
  
  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
      if control == view.rightCalloutAccessoryView {
          if let doSomething = view.annotation?.title! {
             print("do something")
          }
      }
  }
 

}





  // MARK: - setup
//
//  override func viewWillAppear(_ animated: Bool) {
//      super.viewDidLoad()
//      ///Setup blur containers
//      blurContainer.layer.cornerRadius = 25
//      blurContainer.layer.masksToBounds = true
//      blurButtonContainer.layer.cornerRadius = 25
//      blurButtonContainer.layer.masksToBounds = true
//
//      locationManager.delegate = self
//      locationManager.desiredAccuracy = kCLLocationAccuracyBest
//
//      locationManager.requestWhenInUseAuthorization()
//      locationManager.startUpdatingLocation()
//
//      map.addAnnotation(pin) //?
//  }

  // MARK: - render location

//  func render() {
//      let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//      let region = MKCoordinateRegion(center: lastCoordinate!, span: span)
//      map.setRegion(region, animated: true)
//  }
//
//  func updateLabel() {
//      let firstLine = "My location:\n"
//      let secondLine = String(format: "Latitude: %.2f\n", lastLatitude!)
//      let thirdLine = String(format: "Longtitude: %2.f", lastLongitude!)
//      let text = firstLine + secondLine + thirdLine
//      locationLabel.text = text
//  }

//  @IBAction func shareButtonTapped(_ sender: UIButton) {
//      locationManager.startUpdatingLocation()
//      locationManager.requestLocation()
//      guard lastCoordinate != nil else { return }
//      let text = locationLabel.text!
//      let vc = UIActivityViewController(activityItems: [text], applicationActivities: [])
//      vc.popoverPresentationController?.sourceView = blurButtonContainer
//      present(vc, animated: true)
//  }


// MARK: - Location Manager Delegate

//extension ViewController: CLLocationManagerDelegate {
//
//  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//      if let location = locations.last {
//          manager.stopUpdatingLocation()
//
//          lastCoordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
//                                                  longitude: location.coordinate.longitude)
//          render()
//      }
//  }
//
//  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//      print(error.localizedDescription.description)
//  }
//}
 
