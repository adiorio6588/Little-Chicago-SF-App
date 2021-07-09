//
//  HomeViewModel.swift
//  Little Chicago SF App
//
//  Created by mr_robot on 7/2/21.
//

import SwiftUI
import CoreLocation

//Fetching User Location....
class HomeViewModel: NSObject,ObservableObject,CLLocationManagerDelegate{
    
    @Published var locationManager = CLLocationManager()
    @Published var search = ""

    // Location Details....
    @Published var userLocation : CLLocation!
    @Published var userAddress = ""
    @Published var noLocation = false
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        // Checking Location Access....
        
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("authorized")
            self.noLocation = false
            manager.requestLocation()
        case .denied:
            print("denied")
            self.noLocation = true
        default:
            print("unknown")
            self.noLocation = false
            // Direct Call
            locationManager.requestWhenInUseAuthorization()
            // Modifying Info.plist....
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error:
        Error){
        
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Reading User Location And Extracting Details...
        
        self.userLocation = locations.last
        self.extractLocation()
    }
    
    func extractLocation(){
            
        CLGeocoder().reverseGeocodeLocation(self.userLocation) { (res, err) in
            
            guard let safeData = res else{return}
            
            var address = ""
            
            // Getting Area And Locatlity Name....
            
            address += safeData.first?.name ?? ""
            address += ", "
            address += safeData.first?.locality ?? ""
            
            self.userAddress = address 
        }
        
    }
}
