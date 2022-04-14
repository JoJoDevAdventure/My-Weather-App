//
//  ThirdCustomCell.swift
//  My Weather App
//
//  Created by Youssef Bhl on 11/02/2022.
//

import UIKit

class ThirdCustomCell: UITableViewCell {
    
    
    @IBOutlet weak var iconImageLBL: UIImageView!
    @IBOutlet weak var tempLBL: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var humidityLBL: UILabel!
    @IBOutlet weak var dateLBL: UILabel!
    
    static let identifier = "ThirdCustomCell"
    
    func configure(_ currentWeather : WeatherInfo) {
        ImageDownloader.shared.fromUrlString(currentWeather.weather[0].icon) { data in
            self.iconImageLBL.image = UIImage(data: data!)
        }
        tempLBL.text = String(format: "%0.f", currentWeather.main.temp) + "ºC"
        windSpeed.text = String(format: "%0.f", currentWeather.wind.speed) + "MpH"
        humidityLBL.text = String(format: "%0.f"  , currentWeather.main.humidity) + "%"
        var date = currentWeather.dt_txt
        for _ in 0...2 {
            date.removeLast()
        }
        date = date.replacingOccurrences(of: "-", with: "/")
        dateLBL.text = date
    }
    
}

