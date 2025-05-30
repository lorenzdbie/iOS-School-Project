//
//  LocationManager.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 1/11/2023.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject{
    
    private let manager = CLLocationManager()
    @Published var userLocation: CLLocation?
    @Published var shareLoaction: Bool?
    static let shared = LocationManager()
    
    override init(){
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        manager.distanceFilter = 100
        manager.startUpdatingLocation()
    }
    func dismissLocation(){
        shareLoaction = false
    }
    
    func requestLocation(){
        manager.requestWhenInUseAuthorization()
    }
}

extension LocationManager: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined:
            print("DEBUG: Not Determined")
        case .restricted:
            print("DEBUG: Restricted")
        case .denied:
            print("DEBUG: Denied")
        case .authorizedAlways:
            print("DEBUG: Auth always")
        case .authorizedWhenInUse:
            print("DEBUG: Auth when in use")
        @unknown default:
        break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.userLocation = location
        
    }
}
