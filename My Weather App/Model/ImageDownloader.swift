//
//  ImageDownloader.swift
//  My Weather App
//
//  Created by Youssef Bhl on 12/02/2022.
//

import Foundation

class ImageDownloader {
    static let shared = ImageDownloader()
    
    func fromUrlString(_ icon: String, completion: @escaping((Data?) -> Void)) {
        guard let url = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")  else {completion(nil); return}
        URLSession.shared.dataTask(with: url) { d, _, _ in
            DispatchQueue.main.async {
                completion(d)
            }
        }.resume()
    }
}
