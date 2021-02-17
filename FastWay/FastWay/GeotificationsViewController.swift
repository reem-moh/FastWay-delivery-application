//
//  GeotificationsViewController.swift
//  FastWay
//
//  Created by Ghaida . on 05/07/1442 AH.
//


import UIKit
import MapKit
import CoreLocation
import SwiftUI

enum PreferencesKeys: String {
  case savedItems
}

class GeotificationsViewController: UIViewController {
  @IBOutlet weak var mapView: MKMapView!

  var geotifications: [Geotification] = []
  lazy var locationManager = CLLocationManager()

  override func viewDidLoad() {
    super.viewDidLoad()

    // 1
    locationManager.delegate = self
    // 2
    locationManager.requestAlwaysAuthorization()
    // 3
    loadAllGeotifications()
  }

/*
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "addGeotification",
      let navigationController = segue.destination as? UINavigationController,
      let addVC = navigationController.viewControllers.first as? AddGeotificationViewController {
      addVC.delegate = self
    }
  }*/

  // MARK: Loading and saving functions
  func loadAllGeotifications() {
    geotifications.removeAll()
    let allGeotifications = Geotification.allGeotifications()
    allGeotifications.forEach { add($0) }
  }

  func saveAllGeotifications() {
    let encoder = JSONEncoder()
    do {
      let data = try encoder.encode(geotifications)
      UserDefaults.standard.set(data, forKey: PreferencesKeys.savedItems.rawValue)
    } catch {
      print("error encoding geotifications")
    }
  }

  // MARK: Functions that update the model/associated views with geotification changes
  func add(_ geotification: Geotification) {
    geotifications.append(geotification)
    mapView.addAnnotation(geotification)
    addRadiusOverlay(forGeotification: geotification)
    updateGeotificationsCount()
  }

  func remove(_ geotification: Geotification) {
    guard let index = geotifications.firstIndex(of: geotification) else { return }
    geotifications.remove(at: index)
    mapView.removeAnnotation(geotification)
    removeRadiusOverlay(forGeotification: geotification)
    updateGeotificationsCount()
  }

  func updateGeotificationsCount() {
    title = "Pick up location: \(geotifications.count)"
    navigationItem.rightBarButtonItem?.isEnabled = (geotifications.count < 20)
  }

  // MARK: Map overlay functions
  func addRadiusOverlay(forGeotification geotification: Geotification) {
    mapView.addOverlay(MKCircle(center: geotification.coordinate, radius: geotification.radius))
  }

  func removeRadiusOverlay(forGeotification geotification: Geotification) {
    // Find exactly one overlay which has the same coordinates & radius to remove
    guard let overlays = mapView?.overlays else { return }
    for overlay in overlays {
      guard let circleOverlay = overlay as? MKCircle else { continue }
      let coord = circleOverlay.coordinate
      if coord.latitude == geotification.coordinate.latitude &&
        coord.longitude == geotification.coordinate.longitude &&
        circleOverlay.radius == geotification.radius {
        mapView.removeOverlay(circleOverlay)
        break
      }
    }
  }

  // MARK: Other mapview functions
  @IBAction func zoomToCurrentLocation(sender: AnyObject) {
    mapView.zoomToLocation(mapView.userLocation.location)
  }

  // MARK: Put monitoring functions below
  func startMonitoring(geotification: Geotification) {
    // 1
    if !CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
      showAlert(
        withTitle: "Error",
        message: "Geofencing is not supported on this device!")
      return
    }

    // 2
    let fenceRegion = geotification.region
    locationManager.startMonitoring(for: fenceRegion)
  }

  func stopMonitoring(geotification: Geotification) {
    for region in locationManager.monitoredRegions {
      guard
        let circularRegion = region as? CLCircularRegion,
        circularRegion.identifier == geotification.identifier
      else { continue }

      locationManager.stopMonitoring(for: circularRegion)
    }
  }
}

/*
// MARK: AddGeotificationViewControllerDelegate
extension GeotificationsViewController: AddGeotificationsViewControllerDelegate {
  func addGeotificationViewController(
    _ controller: AddGeotificationViewController,
    didAddGeotification geotification: Geotification
  ) {
    controller.dismiss(animated: true, completion: nil)

    // 1
    geotification.clampRadius(maxRadius:
      locationManager.maximumRegionMonitoringDistance)
    add(geotification)

    // 2
    startMonitoring(geotification: geotification)
    saveAllGeotifications()
  }
}
*/

// MARK: - Location Manager Delegate
extension GeotificationsViewController: CLLocationManagerDelegate {
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    // 1
    let status = manager.authorizationStatus

    // 2
    mapView.showsUserLocation = (status == .authorizedAlways)

    // 3
    if status != .authorizedAlways {
      let message = """
      Your geotification is saved but will only be activated once you grant
      Geotify permission to access the device location.
      """
      showAlert(withTitle: "Warning", message: message)
    }
  }

  func locationManager(
    _ manager: CLLocationManager,
    monitoringDidFailFor region: CLRegion?,
    withError error: Error
  ) {
    guard let region = region else {
      print("Monitoring failed for unknown region")
      return
    }
    print("Monitoring failed for region with identifier: \(region.identifier)")
  }

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Location Manager failed with the following error: \(error)")
  }
}

// MARK: - MapView Delegate
extension GeotificationsViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    let identifier = "myGeotification"
    if annotation is Geotification {
      var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
      if annotationView == nil {
        annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        annotationView?.canShowCallout = true
        let removeButton = UIButton(type: .custom)
        removeButton.frame = CGRect(x: 0, y: 0, width: 23, height: 23)
        removeButton.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        annotationView?.leftCalloutAccessoryView = removeButton
      } else {
        annotationView?.annotation = annotation
      }
      return annotationView
    }
    return nil
  }

  func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    if overlay is MKCircle {
      let circleRenderer = MKCircleRenderer(overlay: overlay)
      circleRenderer.lineWidth = 1.0
      circleRenderer.strokeColor = .purple
      circleRenderer.fillColor = UIColor.purple.withAlphaComponent(0.4)
      return circleRenderer
    }
    return MKOverlayRenderer(overlay: overlay)
  }

  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    // Delete geotification
    guard let geotification = view.annotation as? Geotification else { return }
    stopMonitoring(geotification: geotification)
    remove(geotification)
    saveAllGeotifications()
  }
}
