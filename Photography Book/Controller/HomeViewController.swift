//
//  HomeViewController.swift
//  Photography Book
//
//  Created by Hekmat on 5/1/20.
//  Copyright © 2020 Hekmat Barbar. All rights reserved.
//

import UIKit
import Firebase
import MapKit
import CoreLocation
import FirebaseAuth

class HomeViewController: UIViewController{

    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    
    @IBOutlet weak var slideView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    var menuDisplayed: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //check if user is logged in
        if(!isUserLoggedIn()){
            showLoginScreen()
        }
        
        mapView.delegate = self
        menuDisplayed = false
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        mapView.centerToLocation(initialLocation)
        let oahuCenter = CLLocation(latitude: 21.4765, longitude: -157.9647)
        let region = MKCoordinateRegion(
          center: oahuCenter.coordinate,
          latitudinalMeters: 50000,
          longitudinalMeters: 60000)
        mapView.setCameraBoundary(
          MKMapView.CameraBoundary(coordinateRegion: region),
          animated: true)
        
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
        mapView.setCameraZoomRange(zoomRange, animated: true)
        
        let artwork = Marker(
          title: "King David Kalakaua",
          locationName: "Waikiki Gateway Park",
          discipline: "Sculpture",
          coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
        mapView.addAnnotation(artwork)
         
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(view.annotation?.title)
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("easy")
        performSegue(withIdentifier: "HomeToDetail", sender: nil)
    }

    @IBAction func menuTapped(_ sender: Any) {
        if(menuDisplayed!){
            leading.constant = 0
            trailing.constant = 0
            menuDisplayed = false
        }else{
            leading.constant = 150
            trailing.constant = -150
            menuDisplayed = true
        }
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: { (error) in
            print("sdf")
        })
    }
    
    func showLoginScreen() {
        let loginVC = self.storyboard!.instantiateViewController(withIdentifier: "LoginView") as! LoginViewController
        let navController = UINavigationController(rootViewController: loginVC)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated:true, completion: nil)
    }
    
    func isUserLoggedIn() -> Bool{
        if Auth.auth().currentUser == nil{
            print("no user is logged in")
            return false
        }else{
            print("user is logged in")
            return true
        }
    }
    @IBAction func logoutClicked(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            print("user logged out")
            showLoginScreen()
        }catch{
            print("error while loggin out")
        }
    }
    
}
private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
/*
extension HomeViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //
    }
}

*/

extension HomeViewController: MKMapViewDelegate {
  // 1
  func mapView(
    _ mapView: MKMapView,
    viewFor annotation: MKAnnotation
  ) -> MKAnnotationView? {
    // 2
    guard let annotation = annotation as? Marker else {
      return nil
    }
    // 3
    let identifier = "artwork"
    var view: MKMarkerAnnotationView
    // 4
    if let dequeuedView = mapView.dequeueReusableAnnotationView(
      withIdentifier: identifier) as? MKMarkerAnnotationView {
      dequeuedView.annotation = annotation
      view = dequeuedView
    } else {
      // 5
      view = MKMarkerAnnotationView(
        annotation: annotation,
        reuseIdentifier: identifier)
      view.canShowCallout = true
      view.calloutOffset = CGPoint(x: -5, y: 5)
      view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
    }
    return view
  }
}
