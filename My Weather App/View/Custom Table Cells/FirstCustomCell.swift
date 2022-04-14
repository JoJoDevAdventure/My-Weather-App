//
//  FirstCustomCell.swift
//  My Weather App
//
//  Created by Youssef Bhl on 11/02/2022.
//

import UIKit

class FirstCustomCell: UITableViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var tempLBL: UILabel!
    @IBOutlet weak var maxLBL: UILabel!
    @IBOutlet weak var minLBL: UILabel!
    @IBOutlet weak var windSpeedLBL: UILabel!
    @IBOutlet weak var locationLBL: UILabel!
    @IBOutlet weak var dateLBL: UILabel!
    
    static let identifier = "FirstCustomCell"
    
    var  currentWeather: WeatherInfo?
    var min : Float?
    var max : Float?
    var currentLocation = "Paris"
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setup()
    }
    
    
    
    private func setup() {
        guard currentWeather != nil else { return }
        ImageDownloader.shared.fromUrlString(currentWeather!.weather[0].icon) { d in
            self.iconImage.image = UIImage(data: d!)
        }
        tempLBL.text = String(format: "%0.f", currentWeather!.main.temp) + "ºC"
        maxLBL.text = String(format: "%0.f" , max!) + "ºC"
        minLBL.text = String(format: "%0.f" , min!) + "ºC"
        windSpeedLBL.text = String(format: "%0.f" , currentWeather!.wind.speed) + "Km/h"
        locationLBL.text = currentLocation
        var date = currentWeather!.dt_txt
        for _ in 0...10{
            date.removeFirst()
        }
        date.removeLast()
        date.removeLast()
        date.removeLast()
        dateLBL.text = date
    }
}
