//
//  MapsController.swift
//  Como en Casa
//
//  Created by Rodolfo Castillo on 7/30/16.
//  Copyright © 2016 Rodolfo Castillo. All rights reserved.
//

import UIKit
import MapKit

class MapsController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    var navBar: mapsNavController!
    var map: MKMapView!
    var locManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locManager = CLLocationManager()
        self.locManager.delegate = self
        self.locManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locManager.requestWhenInUseAuthorization()
        self.locManager.requestLocation()
        
        self.map = MKMapView(frame: self.view.frame)
        self.navBar = mapsNavController(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0))
        self.navBar.frame.origin.y = 0 - self.navBar.frame.height
        
        self.view.addSubview(map)
        self.view.addSubview(navBar)
        self.navBar.callParent(self)
        self.navBarAppear()
        
    }
    
    func navBarAppear(){
        UIView.animateWithDuration(0.4, delay: 0.89, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.3, options: [], animations: {
                self.navBar.frame.origin.y = 0
            }) { (finished) in
                
        }
    }
    
    func performSearch(sender: AnyObject){
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = self.navBar.searchBar.text!
        request.region = map.region
        
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler { (response, error) in
            guard let response = response else {
                print("Search error: \(error)")
                return
            }
            
            for item in response.mapItems {
                print(item)
                self.addAnnotationForMap(item)
            }
        }
    }
}

extension MapsController: UITextFieldDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            locManager.requestLocation()
            
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            if let location = locations.first {
                let span = MKCoordinateSpanMake(0.005, 0.005)
                let region = MKCoordinateRegion(center: location.coordinate, span: span)
                self.map.setRegion(region, animated: true)
                self.addAnnotationForMap(MKMapItem(placemark: MKPlacemark(coordinate: location.coordinate, addressDictionary: nil)))
            }
            print("location:: \(location)")
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error:: \(error)")
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "test"
        
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView!.image = UIImage(named:"xaxas")
            anView!.canShowCallout = true
        }
        else {
            //we are re-using a view, update its annotation reference...
            anView!.annotation = annotation
        }
        
        return anView
    }
    
    func addAnnotationForMap(MapItem: MKMapItem){
        var myPin = MKPointAnnotation()
        myPin.coordinate = MapItem.placemark.coordinate
        myPin.title = MapItem.placemark.title
        self.map.addAnnotation(myPin)
        
        self.getLocation(CLLocation(latitude: myPin.coordinate.latitude, longitude: myPin.coordinate.longitude))
        
        var anView:MKAnnotationView = MKAnnotationView()
        anView.annotation = myPin
        anView.canShowCallout = true
        anView.enabled = true
        
        self.map.showAnnotations([myPin], animated: true)
        
    }
    
    func getLocation(location: CLLocation){
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            print(location)
            
            if error != nil {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }
            
            if placemarks!.count > 0 {
                let pm = placemarks![0] as! CLPlacemark
                print(pm.locality)
                print(pm.administrativeArea)
                print(pm.postalCode)
                print(pm.subLocality)
                print(pm.thoroughfare)
                print(pm.subThoroughfare)
                
                var adressItems : [AnyObject?] = [pm.thoroughfare, pm.subThoroughfare, pm.postalCode, pm.subLocality, pm.subAdministrativeArea, pm.administrativeArea, pm.locality]
                
                var adressString = ""
                var auxFlag = 0
                
                for StringItem in adressItems {
                    if let aux = StringItem {
                        
                        if auxFlag >= 1 {
                            if auxFlag == adressItems.count - 1 {
                                adressString = adressString + "\(aux)."
                            }
                            adressString = adressString + "\(aux), "
                        } else {
                            adressString = adressString + "\(aux) "
                        }
                        
                        
                    }
                    auxFlag += 1
                }
                
                
                self.navBar.searchBar.text = adressString
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
            else {
                print("Problem with the data received from geocoder")
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
        })
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.returnKeyType == .Search {
            self.performSearch(self)
            self.navBar.searchBar.resignFirstResponder()
            return true
        } else {
            return true
        }
    }
}
