//
//  DetailViewController.swift
//  Reminders
//
//  Created by Michele Mola on 20/09/2018.
//  Copyright © 2018 Michele Mola. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class DetailViewController: UITableViewController {
  
  var context: NSManagedObjectContext?
  var reminder: Reminder?
  
  @IBOutlet weak var textLabel: UITextField!
  @IBOutlet weak var isEnabledSwitch: UISwitch!
  @IBOutlet weak var modalitySegControl: UISegmentedControl!
  @IBOutlet weak var mapView: MKMapView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    mapView.delegate = self
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showLocation" {
      if let vc = segue.destination as? LocationViewController {
        vc.delegate = self
      }
    }
  }
  
  func addCircle(toCoordinate coordinate: CLLocationCoordinate2D) {
    let circle = MKCircle(center: coordinate, radius: 50 as CLLocationDistance)
    self.mapView.addOverlay(circle)
  }
  
}

extension DetailViewController: LocationViewControllerDelegate {
  func location(withCoordinate coordinate: CLLocationCoordinate2D) {
    let annotation = MKPointAnnotation()
    annotation.title = "Point"
    annotation.coordinate = coordinate
    self.mapView.addAnnotation(annotation)
    
    let span = MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
    let region = MKCoordinateRegion(center: coordinate, span: span)
    self.mapView.setRegion(region, animated: true)
    
    self.addCircle(toCoordinate: coordinate)
  }
}

extension DetailViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    let circle = MKCircleRenderer(overlay: overlay)
    circle.strokeColor = UIColor.red
    circle.fillColor = UIColor.red.withAlphaComponent(0.1)
    circle.lineWidth = 1
    return circle
  }
}

