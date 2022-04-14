//
//  UDHeloper.swift
//  My Weather App
//
//  Created by Youssef Bhl on 18/02/2022.
//

import Foundation

class UDHelper {
    
    static let shared = UDHelper()
    
    private let userDefaults = UserDefaults.standard
    private let currentLocationKey = "CurrentLocationKey"
    private let currentLatKey = "CurrentLatKey"
    private let currentLonKey = "CurrentLonKey"
    private let allLocationsKey = "AllLocations"
    private let initialLocaton = ["Paris", "New York", "Marseille", "Tunis"]
    
    func getLocation() -> String {
        if let currentLocation = userDefaults.string(forKey: currentLocationKey) {
            return currentLocation
        }
        return "Paris"
    }
    
    func setLocation(_ newCurrent: String) {
        userDefaults.set(newCurrent, forKey: currentLocationKey)
    }
    
    func getLat() -> Float {
        let lat = userDefaults.float(forKey: currentLatKey)
        return lat
    }
    
    func setLat(_ lat: Float) {
        userDefaults.set(lat, forKey: currentLatKey)
    }
    
    func getLon() -> Float {
        let lon = userDefaults.float(forKey: currentLonKey)
        return lon
    }
    
    func setLon(_ lon: Float) {
        userDefaults.set(lon, forKey: currentLatKey)
    }
    
    func getArray() -> [String] {
        if let array = userDefaults.array(forKey: allLocationsKey) as? [String] {
            return array
        }
        return []
    }
    
    func setArray(_ newValue: String) {
        var a = getArray()
        a.append(newValue)
        userDefaults.set(a, forKey: allLocationsKey)
    }
    
    func restArray() {
        var a = getArray()
        a.removeAll()
        userDefaults.set(a, forKey: allLocationsKey)
    }
    
    func initialize() {
        let existantLocation = getArray()
        if existantLocation.count == 0 {
            initialLocaton.forEach { location in
                setArray(location)
            }
        }
        let currentLocation = getLocation()
        if currentLocation == "" {
            setLocation("Paris")
        }
    }

}
