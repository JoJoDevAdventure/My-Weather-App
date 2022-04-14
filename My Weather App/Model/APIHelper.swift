//
//  APIHelper.swift
//  My Weather App
//
//  Created by Youssef Bhl on 10/02/2022.
//

import Foundation
import MapKit

class APIHelper {
    
    
    static let shared = APIHelper()
    
    //api.openweathermap.org/data/2.5/forecast?lat={lat}&lon={lon}&appid={API key}
    let apiEntryPoint = "https://api.openweathermap.org/data/2.5/"
    let apiKey = "384893a55a916e975c2f3b3838735bb6" // TODO
    let lat = "lat"
    let lon = "lon"
    let appId = "appid"
    let units = "units"
    let unit = "metric"
    let cnts = "cnt"
    let langs = "lang"
    let lang = "fr"
    
    
    func getUrl(_ lat : CLLocationDegrees, _ lon : CLLocationDegrees) -> URL? {
        var urlString = apiEntryPoint
        urlString += "forecast?"
        urlString += "\(self.lat)=\(lat)"
        urlString += "&\(self.lon)=\(lon)"
        urlString += "&\(self.appId)=\(self.apiKey)"
        urlString += "&\(self.units)=\(self.unit)"
        urlString += "&\(self.langs)=\(self.lang)"
        
        return URL(string: urlString)
    }
    
    func performRequest(_ lat: CLLocationDegrees, _ lon : CLLocationDegrees, completion: @escaping(([WeatherInfo]) -> Void)) {
        if let url = getUrl(lat, lon) {
            print(url)
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let d = data {
                    let decoder = JSONDecoder()
                    do {
                        let weather = try decoder.decode(APIResult.self, from: d)
                        completion(weather.list)
                    } catch {
                        print(error.localizedDescription)
                    }
                } else {
                    completion([])
                }
            }.resume()
        } else {
            completion([])
        }
    }
}
