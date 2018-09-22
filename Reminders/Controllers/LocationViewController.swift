//
//  LocationViewController.swift
//  Reminders
//
//  Created by Michele Mola on 22/09/2018.
//  Copyright © 2018 Michele Mola. All rights reserved.
//

import UIKit
import MapKit

protocol LocationViewControllerDelegate: class {
  func location(withCoordinate coordinate: CLLocationCoordinate2D)
}

class LocationViewController: UIViewController {
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var mapView: MKMapView!
  
  weak var delegate: LocationViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchBar.delegate = self
    mapView.delegate = self
    // Do any additional setup after loading the view.
  }
  
  func search() {
    let searchRequest = MKLocalSearch.Request()
    searchRequest.naturalLanguageQuery = searchBar.text
    
    let activeSearch = MKLocalSearch(request: searchRequest)
    
    activeSearch.start { (response, error) in
      
      if let response = response {
        let annotations = self.mapView.annotations
        self.mapView.removeAnnotations(annotations)
        
        let latitude = response.boundingRegion.center.latitude
        let longitude = response.boundingRegion.center.longitude
        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        
        let annotation = MKPointAnnotation()
        annotation.title = self.searchBar.text
        annotation.coordinate = coordinate
        self.mapView.addAnnotation(annotation)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        self.mapView.setRegion(region, animated: true)
        
        self.addCircle(toCoordinate: coordinate)
        
      }
    }
  }
  
  func addCircle(toCoordinate coordinate: CLLocationCoordinate2D) {
    let circle = MKCircle(center: coordinate, radius: 50 as CLLocationDistance)
    self.mapView.addOverlay(circle)
  }
  
  @IBAction func donePressed(_ sender: Any) {
    sendLocation()
  }
  
  func sendLocation() {
    if let annotation = self.mapView.annotations.first {
      self.delegate?.location(withCoordinate: annotation.coordinate)
      
      navigationController?.popViewController(animated: true)
      dismiss(animated: true, completion: nil)
    } else {
      alertWith(title: "Alert", message: "No location chosen")
    }
  }
  
  func alertWith(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
}

extension LocationViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    search()
  }
}

extension LocationViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    let circle = MKCircleRenderer(overlay: overlay)
    circle.strokeColor = UIColor.red
    circle.fillColor = UIColor.red.withAlphaComponent(0.1)
    circle.lineWidth = 1
    return circle
  }
}
