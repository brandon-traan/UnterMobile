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

class BookViewController: UIViewController {

    // MARK: UI Properties
    @IBOutlet weak var mapView: GMSMapView!
    
    // var markers = ()
    
    private let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        // Long & Lat RMIT Building 56 Coordinates
        // Longitude: 144.96554013
        // Latitude: -37.80530242
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)


        
//        for vehicle in vehicles {
//            longitude.append((vehicle.location?.longitude)!)
//            latitude.append((vehicle.location?.latitude)!)
//        }
    }
    
//    //
//    // MARK: Create Dummy Vehciles
//    //
//    func createDummyVehicles() {
//        let context = getContext()
//
//        let entity = NSEntityDescription.entity(forEntityName: "Vehicles", in: context)
//        let vehicle = Vehicles(entity: entity!, insertInto: context)
//
//        vehicle.make = "Toyota"
//        vehicle.model = "Camry"
//        vehicle.year = "2018"
//        vehicle.location?.latitude = -37.80594636283243
//        vehicle.location?.longitude = 144.95888406608893
//
//        do {
//            try context.save()
//            print("Save Created Object")
//
//        } catch {
//            print("Failed Saving Object")
//        }
//    }
    
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
        
        var vehicles : [Vehicles] = []
        
        let managedContext = getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Vehicles")
        
        do {
            vehicles = try managedContext.fetch(fetchRequest) as! [Vehicles]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        for vehicle in vehicles {
            print(vehicles.count)
            print(vehicle.make!)
            print("Google Maps " + String(vehicle.location.latitude))
            
//            let position = CLLocationCoordinate2D(latitude: vehicle.location.latitude, longitude: vehicle.location.longitude)
//            let marker = GMSMarker(position: position)
//            marker.title = vehicle.make! + " " + vehicle.model!
//            marker.map = mapView
        }
//        let position = CLLocationCoordinate2D(latitude: -37.80590228, longitude: 144.96605289)
//        let marker = GMSMarker(position: position)
//        marker.title = "Hello World"
//        marker.map = mapView
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        locationManager.stopUpdatingLocation()
    }
}

