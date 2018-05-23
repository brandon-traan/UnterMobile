//
//  BookingViewController.swift
//  Unter
//
//  Created by Brandon Tran on 30/4/18.
//  Copyright © 2018 Brandon Tran. All rights reserved.
//

import UIKit
import CoreData
import GoogleMaps

class BookViewController: UIViewController, GMSMapViewDelegate {

    // MARK: UI Properties
    @IBOutlet weak var mapView: GMSMapView!
    
    var marker: GMSMarker?
    var fetchedVehicles : [Vehicles] = []
    
    private let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let managedContext = getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Vehicles")
        
        do {
            fetchedVehicles = try managedContext.fetch(fetchRequest) as! [Vehicles]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        mapView.delegate = self
        
        // Long & Lat RMIT Building 56 Coordinates
        // Longitude: 144.96554013
        // Latitude: -37.80530242
        for vehicle in fetchedVehicles {
            print(fetchedVehicles.count)
            print(vehicle.make!)
            print(vehicle.location!.latitude)
            print(vehicle.location!.longitude)
            
            let position = CLLocationCoordinate2D(latitude: vehicle.location!.latitude, longitude: vehicle.location!.longitude)
            
            let marker = GMSMarker(position: position)
            marker.title = vehicle.make! + " " + vehicle.model!
            marker.snippet = "hello world. Example of a long description. Can't stop me now. Will this fit on an iPhone screen?"
            marker.map = mapView
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Booking Info" {
            if let destination = segue.destination as? BookInfoViewController {
                // Pass Variables
            }
        }
    }
    
     func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        performSegue(withIdentifier: "Show Booking Info", sender: self)
        return true
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}

//
// MARK: - CLLocationManagerDelegate
//
extension BookViewController: CLLocationManagerDelegate  {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            return
        }
        locationManager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 50, bearing: 0, viewingAngle: 0)
        locationManager.stopUpdatingLocation()
    }
}

